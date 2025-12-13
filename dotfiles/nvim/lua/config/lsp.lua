-- Set up nvim-cmp.
local cmp = require('cmp')

cmp.setup({
	snippet = {
		expand = function(args)
			vim.fn["vsnip#anonymous"](args.body)
		end,
	},
	window = {
		completion = cmp.config.window.bordered(),
		documentation = cmp.config.window.bordered(),
	},
	mapping = cmp.mapping.preset.insert({
		['<C-b>'] = cmp.mapping.scroll_docs(-4),
		['<C-f>'] = cmp.mapping.scroll_docs(4),
		['<C-Space>'] = cmp.mapping.complete(),
		['<C-e>'] = cmp.mapping.abort(),
		['<CR>'] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
	}),
	sources = cmp.config.sources({
		{ name = "copilot" },
		{ name = 'nvim_lsp' },
		{ name = 'vsnip' },
	}, {
		{ name = 'buffer' },
	})
})

-- Use buffer source for `/` and `?` (if you enabled `native_menu`, this won't work anymore).
cmp.setup.cmdline({ '/', '?' }, {
	mapping = cmp.mapping.preset.cmdline(),
	sources = {
		{ name = 'buffer' }
	}
})

-- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
cmp.setup.cmdline(':', {
	mapping = cmp.mapping.preset.cmdline(),
	sources = cmp.config.sources({
		{ name = 'path' }
	}, {
		{ name = 'cmdline' }
	}),
	matching = { disallow_symbol_nonprefix_matching = false }
})


--------------------
-- Servers config --
--------------------
local capabilities = require("cmp_nvim_lsp").default_capabilities()

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
