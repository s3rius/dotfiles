local mini_pick = require("mini.pick")
local history = {}

local function add_buffer(event)
	for i, v in ipairs(history) do
		if v == event.buf then
			table.remove(history, i)
			break
		end
	end
	table.insert(history, 1, event.buf)
end

local function remove_buffer(event)
	for i, v in ipairs(history) do
		if v == event.buf then
			table.remove(history, i)
			break
		end
	end
end

local function prepare_to_show(existing)
	-- Clean up history to only include existing buffers
	history = vim.tbl_filter(function(item) return vim.tbl_contains(existing, item) end, history)
	-- Add any existing buffers that are not in history to the end
	local prepared = vim.deepcopy(history)
	for _, bufnr in ipairs(existing) do
		if not vim.tbl_contains(prepared, bufnr) then
			table.insert(prepared, bufnr)
		end
	end
	return prepared
end

local function show_buffers(opts)
	local filter = vim.tbl_get(opts, "filters") or {}
	local function inner()
		local filtered_history = {}
		-- Get current working directory to strip from paths
		local cwd = vim.fn.getcwd() .. "/"
		-- List all existing listed buffers
		local existing = vim.tbl_filter(function(bufnr) return vim.api.nvim_buf_is_loaded(bufnr) end,
			vim.api.nvim_list_bufs())
		-- Sort buffers to show most recently used first
		local buffers = prepare_to_show(existing)
		for i, bufnr in ipairs(buffers) do
			-- Skip the current buffer
			if i ~= 1 then
				-- Get buffer name
				local buf_name = vim.api.nvim_buf_get_name(bufnr)
				for _, f in ipairs(filter) do
					if buf_name:match(f) then
						buf_name = nil
						break
					end
				end
				if buf_name == nil then
					print("Filtered out", bufnr)
				elseif buf_name:sub(1, #cwd) == cwd then
					-- Strip cwd from the path if it's there
					table.insert(filtered_history, { text = buf_name:sub(#cwd + 1), bufnr = bufnr })
				elseif buf_name == "" then
					-- If no name, show [No Name]
					table.insert(filtered_history, { text = "[No Name]", bufnr = bufnr })
				else
					-- Otherwise, show full path
					table.insert(filtered_history, { text = buf_name, bufnr = bufnr })
				end
			end
		end
		mini_pick.start({
			source = {
				name = "Select buffer",
				items = filtered_history,
			}
		})
	end
	return inner
end

local M = {}


M.setup = function(opts)
	local ord_buf_group = vim.api.nvim_create_augroup('OrdBuffers', { clear = true })
	vim.api.nvim_create_autocmd({ "BufEnter" }, { callback = add_buffer, group = ord_buf_group })
	vim.api.nvim_create_autocmd({ "BufDelete" }, { callback = remove_buffer, group = ord_buf_group })
	vim.api.nvim_create_user_command("OrderedBuffers", show_buffers(opts), { desc = "Show buffer picker" })
end

return M
