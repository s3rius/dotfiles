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

vim.api.nvim_create_autocmd("LspAttach", {
	group = vim.api.nvim_create_augroup("my.lsp", {}),
	callback = function(args)
		local client = assert(vim.lsp.get_client_by_id(args.data.client_id))
		if client:supports_method("textDocument/implementation") then
			-- Create a keymap for vim.lsp.buf.implementation ...
		end
		-- Enable auto-completion. Note: Use CTRL-Y to select an item. |complete_CTRL-Y|
		if client:supports_method("textDocument/completion") then
			-- Optional: trigger autocompletion on EVERY keypress. May be slow!
			-- local chars = {}; for i = 32, 126 do table.insert(chars, string.char(i)) end
			-- client.server_capabilities.completionProvider.triggerCharacters = chars
			vim.lsp.completion.enable(true, client.id, args.buf, { autotrigger = true })
		end
	end,
})
