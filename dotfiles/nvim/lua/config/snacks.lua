require("snacks").setup({
	dashboard = { enabled = false },
	profiler = { enabled = false },
	-- Enabled plugins
	bigfile = { enabled = true },
	explorer = {
		enabled = true,
		replace_netrw = true,
	},
	indent = { enabled = true },
	input = { enabled = true },
	picker = { enabled = true },
	notifier = { enabled = true },
	quickfile = { enabled = true },
	scope = { enabled = true },
	scroll = { enabled = true },
	statuscolumn = { enabled = true },
	-- words = { enabled = true },
})
vim.ui.input = Snacks.input
vim.ui.select = Snacks.picker.select
