local M = {};


local function parse_output(proc)
	local result = proc:wait()
	local ret = {}
	if result.code == 0 then
		for line in vim.gsplit(result.stdout, "\n", { plain = true, trimempty = true }) do
			if vim.startswith(line, "..") then
				goto continue
			end
			-- Remove everything but current name.
			line = line:gsub("/.*", "")
			ret[line] = true
			::continue::
		end
	end
	return ret
end

local function tracked_files()
	return setmetatable({}, {
		__index = function(self, key)
			local ret = parse_output(vim.system(
				{ "jj", "file", "list", "--ignore-working-copy", "--color", "never", "--quiet", "." }, {
					cwd = key,
					text = true,
				}))
			rawset(self, key, ret)
			return ret
		end,
	})
end

M.tracked_files = tracked_files()

return M
