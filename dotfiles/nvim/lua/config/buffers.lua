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


--- List all buffers
--- @return table<integer>
local function get_buffers()
	local buffers_exec = vim.api.nvim_exec2('buffers', { output = true })
	local cur_bufnr = vim.api.nvim_get_current_buf()
	local items = {}
	for _, l in ipairs(vim.split(buffers_exec.output, '\n')) do
		local buf_str = l:match('^%s*%d+')
		local bufnr   = tonumber(buf_str)
		if bufnr ~= cur_bufnr then
			table.insert(items, bufnr)
		end
	end
	return items
end

local function show_buffers()
	local filtered_history = {}
	-- Get current working directory to strip from paths
	local cwd = vim.fn.getcwd() .. "/"
	local buffers = get_buffers()
	-- We get all our history, but only
	-- show loaded buffers
	for _, bufnr in ipairs(history) do
		if vim.tbl_contains(buffers, bufnr) then
			local bufname = vim.api.nvim_buf_get_name(bufnr)
			-- Strip cwd from the path if it's there
			if bufname:sub(1, #cwd) == cwd then
				table.insert(filtered_history, { text = bufname:sub(#cwd + 1), bufnr = bufnr })
			else
				table.insert(filtered_history, { text = bufname, bufnr = bufnr })
			end
		end
	end
	mini_pick.start({
		source = {
			name = "Select buffer",
			items = filtered_history,
			-- We pass show_icons=True here to
			-- display icons correctly.
			show = function(buf_id, items, query) mini_pick.default_show(buf_id, items, query, { show_icons = true }) end
		}
	})
end

local M = {}

M.setup = function(opts)
	local ord_buf_group = vim.api.nvim_create_augroup('OrdBuffers', { clear = true })
	vim.api.nvim_create_autocmd({ "BufEnter" }, { callback = add_buffer, group = ord_buf_group })
	vim.api.nvim_create_autocmd({ "BufDelete" }, { callback = remove_buffer, group = ord_buf_group })
	vim.api.nvim_create_user_command("OrderedBuffers", show_buffers, { desc = "Show buffer picker" })
end

return M
