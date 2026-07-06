--- Utility module for tracking git-ignored files.
--- Integrates with oil.nvim to refresh the ignored-files cache on directory changes.
local M = {}

--- Parses the stdout of a git process into a set of file/directory names.
--- Skips lines starting with ".." and strips trailing slashes.
---
--- @param proc vim.SystemObj the async git process handle
--- @return table<string, boolean> set of recognized paths
local function parse_output(proc)
	local result = proc:wait()
	local ret = {}
	if result.code == 0 then
		for line in vim.gsplit(result.stdout, "\n", { plain = true, trimempty = true }) do
			if vim.startswith(line, "..") then
				goto continue
			end
			line = line:gsub("/$", "")
			ret[line] = true
			::continue::
		end
	end
	return ret
end

--- Returns a metatable-backed cache where each key is a directory path and each
--- value is a set of git-ignored file/directory names within it. Values are computed
--- on first access via `__index` by running `git ls-files --ignored`.
---
--- @return table<string, table<string, boolean>> cache mapping cwd -> ignored file set
local function _ignored_files()
	return setmetatable({}, {
		__index = function(self, key)
			local ret = parse_output(vim.system(
				{ "git", "ls-files", "--ignored", "--exclude-standard", "--others", "--directory" }, {
					cwd = key,
					text = true,
				}))
			rawset(self, key, ret)
			return ret
		end,
	})
end

--- Lazily-populated cache of git-ignored files per working directory.
---
--- @type table<string, table<string, boolean>>
M.ignored_files = _ignored_files()

--- Hooks into oil.nvim's refresh action to rebuild the ignored-files cache.
--- Call once during plugin initialization.
function M.setup()
	local refresh = require("oil.actions").refresh
	local orig_refresh = refresh.callback
	refresh.callback = function(...)
		M.ignored_files = _ignored_files()
		orig_refresh(...)
	end
end

return M
