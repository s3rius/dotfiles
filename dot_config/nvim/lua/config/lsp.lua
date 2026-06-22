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
vim.lsp.config("jsonls", {
	capabilities = capabilities,
	settings = {
		json = {
			schemas = {
				urls = {
					"https://json.schemastore.org/",
				},
			},
		},
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

vim.lsp.config('vtsls', {
	capabilities = capabilities,
	settings = {
		typescript = {
			tsdk = vim.fn.getcwd() .. "/node_modules/typescript/lib",
		},
		vtsls = {
			tsserver = {
				globalPlugins = {
					{
						name = '@vue/typescript-plugin',
						location = "/usr/lib/node_modules/@vue/language-server",
						languages = { 'vue' },
						configNamespace = 'typescript',
					},
				},
			},
			vue = {
				enabled = true,
			},
		},
	},
	filetypes = { 'typescript', 'javascript', 'javascriptreact', 'typescriptreact', 'vue' },
})

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
		"kotlin_language_server",
		"texlab",
		"marksman",
		"terraformls",
		"gopls",
		"lexical",
		"tombi",
		"jsonls",
		"helm_ls",
		"yamlls",
		"rust_analyzer",
		"zls",
		"neocmake",
		"lexical",
		"dartls",
		"tinymist",
		"gdscript",
		"svelte",
		"vtsls",
		-- "elixirls",
	},
	capabilities
)
