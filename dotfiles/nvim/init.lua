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

-- Packages
vim.pack.add({
	-- Mini plugins
	{ src = "https://github.com/echasnovski/mini.pick" },            -- Picker for random things
	{ src = "https://github.com/echasnovski/mini.files" },           -- File manager.
	{ src = "https://github.com/echasnovski/mini.extra" },           -- Extra features for mini.pick
	{ src = "https://github.com/echasnovski/mini.icons" },           -- Extra features for mini.pick
	-- CMP
	{ src = "https://github.com/hrsh7th/cmp-nvim-lsp" },             -- LSP source for nvim-cmp
	{ src = "https://github.com/hrsh7th/nvim-cmp" },                 -- Completion engine
	{ src = "https://github.com/hrsh7th/cmp-path" },                 -- Path source for nvim-cmp
	{ src = "https://github.com/hrsh7th/cmp-cmdline" },              -- Cmdline source for nvim-cmp
	{ src = "https://github.com/hrsh7th/cmp-vsnip" },                -- Vsnip source for nvim-cmp
	{ src = "https://github.com/hrsh7th/vim-vsnip" },                -- Snippet engine
	{ src = "https://github.com/zbirenbaum/copilot-cmp" },           -- Copilot cmp source
	-- Other plugins
	{ src = "https://github.com/eddyekofo94/gruvbox-flat.nvim" },    -- Gruvbox theme
	{ src = "https://github.com/neovim/nvim-lspconfig" },            -- LSP support
	{ src = "https://github.com/zbirenbaum/copilot.lua" },           -- Copilot
	{ src = "https://github.com/smoka7/hop.nvim" },                  -- EasyMotion
	{ src = "https://github.com/akinsho/toggleterm.nvim" },          -- Terminal integration
	{ src = "https://github.com/folke/which-key.nvim" },             -- Small key helper
	{ src = "https://github.com/mikesmithgh/kitty-scrollback.nvim" }, -- Kitty scrollback integration
	{ src = "https://github.com/nvim-treesitter/nvim-treesitter" },  -- Treesitter for syntax highlighting
	{ src = "https://github.com/linux-cultist/venv-selector.nvim" }, -- For Python virtualenv selection
	{ src = "https://github.com/folke/trouble.nvim" },               -- For showing LSP diagnostics
	{ src = "https://github.com/windwp/nvim-autopairs" },            -- Autopairs for brackets, parens, etc.
})
vim.cmd("colorscheme gruvbox-flat")
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

-- EasyMotion
require("hop").setup()
vim.keymap.set("n", "<leader><leader>w", ":HopWordAC<CR>", { desc = "EasyMotion forward" })
vim.keymap.set("n", "<leader><leader>b", ":HopWordBC<CR>", { desc = "Easy motion backward" })

-- Buffers keymaps
vim.keymap.set("n", "<leader>bc", ":bdelete<CR>", { desc = "Buffer close" })
vim.keymap.set("n", "<leader>bk", ":bdelete!<CR>", { desc = "Buffer kill" })

-- Picker setup
require("mini.pick").setup({ options = { content_from_bottom = true } })
require("mini.extra").setup({})
require("mini.icons").setup({})

vim.keymap.set("n", "<leader>fr", ":Pick resume<CR>", { desc = "Pick resume" })
vim.keymap.set("n", "<leader>fh", ":Pick help<CR>", { desc = "Pick help" })
vim.keymap.set("n", "<leader>ff", ":Pick files<CR>", { desc = "Pick files" })
vim.keymap.set("n", "<leader>fg", ":Pick grep_live<CR>", { desc = "Grep for lines" })

-- LSP-related configs
require("config.lsp")
vim.keymap.set("n", "<C-S-i>", vim.lsp.buf.format, { desc = "Format code" })
-- vim.keymap.set("n", "<C-Space>", vim.lsp.buf.code_action, { desc = "Code actions" })
vim.keymap.set("n", "gd", ":Pick lsp scope='definition'<CR>", { desc = "Go to definition" })
vim.keymap.set("n", "gr", ":Pick lsp scope='references'<CR>", { desc = "Go to references" })
-- vim.keymap.set("i", "<C-space>", vim.lsp.completion.get, { desc = "trigger autocompletion" })
vim.keymap.set("n", "<F2>", vim.lsp.buf.rename, { desc = "Rename symbol" })

require("mini.files").setup({})
vim.keymap.set("n", "<leader>ft", ":lua MiniFiles.open()<CR>", { desc = "Toggle file explorer" })

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

-- Python venv selector setup
require("venv-selector").setup({})
vim.keymap.set("n", "<leader>vs", ":VenvSelect<CR>", { desc = "Select Python virtualenv" })

-- Trouble setup
require("trouble").setup({})
vim.keymap.set(
	"n",
	"<leader>cp",
	"<cmd>Trouble diagnostics toggle filter.buf=0<CR>",
	{ desc = "Show code problems" }
)
vim.keymap.set(
	"n",
	"<leader>cgp",
	"<cmd>Trouble diagnostics toggle<CR>",
	{ desc = "Show global code problems" }
)

require("nvim-autopairs").setup({})

pcall(require, "config.intree")

require("config.buffers").setup({})
vim.keymap.set("n", "<leader>bl", ":OrderedBuffers<CR>", { desc = "Show Buffers" })

require("copilot").setup({
	suggestion = { enabled = false },
	panel = { enabled = false },
})
require("copilot_cmp").setup()
