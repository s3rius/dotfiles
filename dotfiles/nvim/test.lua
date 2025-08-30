print(vim.inspect(vim.tbl_filter(function(bufnr) return not vim.api.nvim_buf_is_loaded(bufnr) end, vim.api.nvim_list_bufs())))
