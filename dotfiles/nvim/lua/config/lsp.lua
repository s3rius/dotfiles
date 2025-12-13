-- Set up nvim-cmp.
require('blink.cmp').setup({
	keymap = { preset = 'enter' },
	appearance = {
		nerd_font_variant = 'mono',
	},
	cmdline = { completion = { ghost_text = { enabled = true } } },
	snippets = { preset = 'luasnip' },
	completion = {
		menu = { border = 'single' },
		documentation = {
			auto_show = true,
			window = { border = 'single' }
		},
	},
	sources = {
		default = { 'lsp', 'path', 'snippets', 'buffer', 'copilot' },
		providers = {
			copilot = {
				name = "copilot",
				module = "blink-copilot",
				score_offset = 100,
				async = true,
			},
		},
	},
	fuzzy = {
		implementation = "prefer_rust_with_warning",
		prebuilt_binaries = {
			download = false,
		}
	},
})

--------------------
-- Servers config --
--------------------
local capabilities = require('blink.cmp').get_lsp_capabilities()

vim.lsp.config("rust_analyzer", {
	capabilities = capabilities,
	settings = {
		["rust-analyzer"] = {
			-- Other Settings ...
			procMacro = {
				ignored = {
					-- leptos_macro = {
					--   -- optional: --
					--   -- "component",
					--   "server",
					-- },
				},
			},
			cargo = {
				loadOutDirsFromCheck = true,
				allFeatures = true,
			},
		},
	},
})
vim.lsp.config("ts_ls", {
	capabilities = capabilities,
	init_options = {
		plugins = {
			{
				name = "@vue/typescript-plugin",
				location = "/usr/lib/node_modules/@vue/typescript-plugin/",
				languages = { "javascript", "typescript", "vue" },
			},
		},
	},
	filetypes = {
		"javascript",
		"typescript",
		"vue",
	},
})
vim.lsp.config("helm_ls", {
	capabilities = capabilities,
	settings = {
		["helm-ls"] = {
			yamlls = {
				path = "yaml-language-server",
			},
		},
	},
})
vim.lsp.config("tombi", {
	capabilities = capabilities,
	settings = {
		["tombi"] = {
			root_markers = { "." },
		},
	},
})

vim.lsp.config("tinymist", {
	capabilities = capabilities,
	settings = {
		formatterMode = "typstyle",
		exportPdf = "onType",
		semanticTokens = "disable"
	}
})

-- vim.lsp.config("yamlls", {
-- 	capabilities = capabilities,
-- 	settings = {
-- 		yaml = {
-- 			schemas = {
-- 				[require('kubernetes').yamlls_schema()] = "*.yaml",
-- 			},
-- 		}
-- 	}
-- })

local function enable_with_capsabilities(servers, capabilities)
	for _, server in ipairs(servers) do
		vim.lsp.config(server, {
			capabilities = capabilities,
		})
		vim.lsp.enable(server)
	end
end

enable_with_capsabilities(
	{
		"lua_ls",
		"clangd",
		"pyright",
		"ruff",
		"vue_ls",
		"kotlin_language_server",
		"texlab",
		"marksman",
		"terraformls",
		"gopls",
		"lexical",
		"tombi",
		"ts_ls",
		"helm_ls",
		"yamlls",
		"rust_analyzer",
		"zls",
		"neocmake",
		"lexical",
		"dartls",
		"tinymist",
		-- "elixirls",
	},
	capabilities
)
