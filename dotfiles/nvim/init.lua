vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

-- Basic settings
vim.o.tabstop = 2
vim.o.relativenumber = true
vim.o.shiftwidth = 2
vim.o.softtabstop = 2
vim.opt.swapfile = false
vim.opt.completeopt = { "menuone", "noselect", "popup" }
vim.o.winborder = 'rounded'
vim.opt.termguicolors = true

local hooks = function(ev)
	local name, kind = ev.data.spec.name, ev.data.kind
	local print_info = function() print("Running", name, kind, "hook") end
	if name == 'LuaSnip' and (kind == 'install' or kind == 'update') then
		print_info()
		vim.system({ 'make', 'install_jsregexp' }, { cwd = ev.data.path }):wait()
	end
	if name == 'blink.cmp' and (kind == 'install' or kind == 'update') then
		print_info()
		vim.system({ 'cargo', '+nightly', 'build', '--release' }, { cwd = ev.data.path, text = true }):wait()
	end
end
vim.api.nvim_create_autocmd('PackChanged', { callback = hooks })

vim.pack.add({
	{ src = "https://github.com/eddyekofo94/gruvbox-flat.nvim" },    -- Gruvbox theme
	{ src = "https://github.com/jacobdot/nvim-web-devicons.nvim" },  -- Icons
	{ src = "https://github.com/neovim/nvim-lspconfig" },            -- LSP support
	{ src = "https://github.com/smoka7/hop.nvim" },                  -- EasyMotion
	{ src = "https://github.com/folke/which-key.nvim" },             -- Small key helper
	{ src = "https://github.com/mikesmithgh/kitty-scrollback.nvim" }, -- Kitty scrollback integration
	{ src = "https://github.com/nvim-treesitter/nvim-treesitter" },  -- Treesitter for syntax highlighting
	{ src = "https://github.com/linux-cultist/venv-selector.nvim" }, -- For Python virtualenv selection
	{ src = "https://github.com/windwp/nvim-autopairs" },            -- Autopairs for brackets, parens, etc.
	{ src = "https://github.com/zbirenbaum/copilot.lua" },           -- Copilot
	{ src = "https://github.com/folke/snacks.nvim" },                -- Lot of QOL improvements
	{
		src = "https://github.com/saghen/blink.cmp",                   -- For autocompletion
		version = vim.version.range('1'),
	},
	{ src = "https://github.com/L3MON4D3/LuaSnip" }, -- For snippets
	{ src = "https://github.com/fang2hou/blink-copilot" }, -- Blink+copilot integration
	{ src = "https://github.com/Dynge/gitmoji.nvim" },    -- Gitmoji
	{ src = "https://github.com/stevearc/oil.nvim" },     -- OIL file picker
})
vim.cmd("colorscheme gruvbox-flat")
vim.cmd("highlight Normal guibg=NONE")
vim.diagnostic.enable()
vim.diagnostic.config({
	virtual_text = true,
	signs = true,
	update_in_insert = false,
	underline = true,
	severity_sort = false,
	float = true,
})
vim.keymap.set("n", "<leader>cr", ":source $MYVIMRC<CR>", { desc = "Reload config" })
vim.keymap.set("n", "<leader>pu", vim.pack.update, { desc = "Update plugins" })

if Snacks == nil then
	-- Because snacks cannot be instantiated twice.
	require("snacks").setup({
		dashboard = { enabled = false },
		profiler = { enabled = false },
		-- Enabled plugins
		bigfile = { enabled = true },
		explorer = {
			enabled = false,
		},
		indent = { enabled = true },
		---@class snake.image.Config
		image = {
			enabled = true,
			doc = {
				enabled = true,
				inline = false,
				float = true,
			}
		},
		input = { enabled = true },
		picker = {
			enabled = true,
		},
		notifier = { enabled = true },
		quickfile = { enabled = true },
		scope = { enabled = true },
		scroll = { enabled = true },
		statuscolumn = { enabled = true },
		terminal = {
			start_insert = false,
			auto_insert = false,
		}
		-- words = { enabled = true },
	})
	vim.ui.input = Snacks.input
	vim.ui.select = Snacks.picker.select
end
vim.keymap.set("n", "<C-`>", function() Snacks.terminal() end, { desc = "FileTree toggle" })
-- Buffers and files
vim.keymap.set("n", "<leader>bl", function() Snacks.picker.buffers({ current = false, sort_lastused = true }) end,
	{ desc = "Buffers list" })
vim.keymap.set("n", "<leader>bc", function() Snacks.bufdelete() end, { desc = "Buffer close" })
-- Picking
vim.keymap.set("n", "<leader>pf", function() Snacks.picker.files() end, { desc = "Pick files" })
vim.keymap.set("n", "<leader>ph", function() Snacks.picker.help() end, { desc = "Pick help" })
vim.keymap.set("n", "<leader>pr", function() Snacks.picker.resume() end, { desc = "Pick resume" })
vim.keymap.set("n", "<leader>pg", function() Snacks.picker.grep() end, { desc = "Pick grep" })

require("hop").setup()
vim.keymap.set({ "n", "o", "v" }, "<leader><leader>w", "<cmd>HopWordAC<CR>",
	{ noremap = true, desc = "EasyMotion forward" })
vim.keymap.set({ "n", "o", "v" }, "<leader><leader>b", "<cmd>HopWordBC<CR>",
	{ noremap = true, desc = "Easy motion backward" })

require("oil").setup({
	default_file_explorer = true,

})
vim.keymap.set("n", "<leader>ft", "<CMD>Oil --float<CR>", { desc = "File Tree" })

require("nvim-treesitter.configs").setup({
	sync_install = true,
	highlight = { enable = true },
	indent = { enable = true },
	auto_install = true,
	ignore_install = {},
	modules = {},
})

require("copilot").setup({
	suggestion = { enabled = false },
	panel = { enabled = false },
	filetypes = {
		markdown = true,
		help = true,
	},
})

require("config.lsp")
vim.keymap.set("n", "<C-S-i>", vim.lsp.buf.format, { desc = "Format code" })
vim.keymap.set("n", "<C-Space>", vim.lsp.buf.code_action, { desc = "Code actions" })
vim.keymap.set("n", "gd", function() Snacks.picker.lsp_definitions() end, { desc = "Go to definition" })
vim.keymap.set("n", "gr", function() Snacks.picker.lsp_references() end, { desc = "Go to references" })
vim.keymap.set("i", "<C-space>", vim.lsp.completion.get, { desc = "trigger autocompletion" })
vim.keymap.set("n", "<F2>", vim.lsp.buf.rename, { desc = "Rename symbol" })

require("venv-selector").setup({})
vim.keymap.set("n", "<leader>vs", ":VenvSelect<CR>", { desc = "Select Python virtualenv" })

pcall(require, "config.intree")
require("nvim-web-devicons").setup({})
require("which-key").setup({})
require("nvim-autopairs").setup({})
require("kitty-scrollback").setup()

