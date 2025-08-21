vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

-- Basic settings
vim.o.tabstop = 2
vim.o.relativenumber = true
vim.o.shiftwidth = 2
vim.o.softtabstop = 2
vim.opt.clipboard = "unnamedplus"
vim.opt.swapfile = false
vim.opt.completeopt = { "menuone", "noselect", "popup" }

-- Packages
vim.pack.add({
	{ src = "https://github.com/eddyekofo94/gruvbox-flat.nvim" },    -- Gruvbox theme
	{ src = "https://github.com/neovim/nvim-lspconfig" },            -- LSP support
	{ src = "https://github.com/stevearc/oil.nvim" },                -- File explorer
	{ src = "https://github.com/echasnovski/mini.pick" },            -- Picker for random things
	{ src = "https://github.com/github/copilot.vim" },               -- Copilot
	{ src = "https://github.com/smoka7/hop.nvim" },                  -- EasyMotion
	{ src = "https://github.com/akinsho/toggleterm.nvim" },          -- Terminal integration
	{ src = "https://github.com/folke/which-key.nvim" },             -- Small key helper
	{ src = "https://github.com/mikesmithgh/kitty-scrollback.nvim" }, -- Kitty scrollback integration
	{ src = "https://github.com/nvim-treesitter/nvim-treesitter" },  -- Treesitter for syntax highlighting
	{
		src = "https://github.com/s3rius/venv-selector.nvim",          -- Local venv selector plugin
		version = "feature/mini-pick",
	},                                                               -- For Python virtualenv selection
})
-- require('telescope').setup()
vim.cmd("colorscheme gruvbox-flat")

vim.keymap.set("n", "<leader>cr", ":source $MYVIMRC<CR>", { desc = "Reload config" })
vim.keymap.set("n", "<leader>pu", vim.pack.update, { desc = "Update plugins" })

-- EasyMotion
require("hop").setup()
vim.keymap.set("n", "<leader><leader>w", ":HopWordAC<CR>", { desc = "EasyMotion forward" })
vim.keymap.set("n", "<leader><leader>b", ":HopWordBC<CR>", { desc = "Easy motion backward" })

-- Buffers keymaps
vim.keymap.set("n", "<leader>bc", ":bdelete<CR>", { desc = "Buffer close" })
vim.keymap.set("n", "<leader>bk", ":bdelete!<CR>", { desc = "Buffer kill" })

-- Picker setup
require("mini.pick").setup({
	options = {
		content_from_bottom = true,
	},
})
vim.keymap.set("n", "<leader>ff", ":Pick files<CR>", { desc = "Pick files" })
vim.keymap.set("n", "<leader>fg", ":Pick grep_live<CR>", { desc = "Grep for lines" })
vim.keymap.set("n", "<leader>bl", ":Pick buffers include_current=false<CR>", { desc = "Pick other buffers" })

-- LSP-related configs
require("config.lsp")
vim.keymap.set("n", "<C-S-i>", vim.lsp.buf.format, { desc = "Format code" })
vim.keymap.set("n", "<C-Space>", vim.lsp.buf.code_action, { desc = "Code actions" })
vim.keymap.set("n", "gd", vim.lsp.buf.definition, { desc = "Go to definition" })
vim.keymap.set("i", "<C-space>", vim.lsp.completion.get, { desc = "trigger autocompletion" })

-- Oil setup
local oil = require("oil")
oil.setup({
	view_options = {
		show_hidden = true,
	},
})
vim.keymap.set("n", "<leader>ft", oil.toggle_float, { desc = "Toggle file explorer" })

-- ToggleTerm
require("toggleterm").setup({
	open_mapping = [[<C-`>]],
	shell = vim.o.shell,
	title_pos = "left",
})

require("which-key").setup()

require("kitty-scrollback").setup()

-- Treesitter setup
require("nvim-treesitter.configs").setup({
	ensure_installed = {
		"c",
		"lua",
		"vim",
		"vimdoc",
		"query",
		"elixir",
		"heex",
		"javascript",
		"html",
		"python",
		"rust",
		"hcl",
		"terraform",
		"yaml",
	},
	sync_install = true,
	highlight = { enable = true },
	indent = { enable = true },
	auto_install = true,
	ignore_install = {},
	modules = {},
})

require("venv-selector").setup({
	options = {},
})
vim.keymap.set("n", "<leader>vs", ":VenvSelect<CR>", { desc = "Select Python virtualenv" })

pcall(require, "config.intree")
