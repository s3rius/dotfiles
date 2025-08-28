vim.lsp.config("rust_analyzer", {
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
vim.lsp.config("lexical", {
	cmd = { "lexical" },
})
vim.lsp.config("ts_ls", {
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
	settings = {
		["helm-ls"] = {
			yamlls = {
				path = "yaml-language-server",
			},
		},
	},
})
vim.lsp.config("taplo", {
	settings = {
		["taplo"] = {
			root_markers = { "." },
		},
	},
})

vim.lsp.enable({
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
	"taplo",
	"lexical",
	"ts_ls",
	"helm_ls",
	"yamlls",
	"rust_analyzer",
	"zls",
	-- "elixirls",
})
