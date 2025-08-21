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

-- require('lsp_signature').setup {
--   bind = true,
--   hint_enable = false,
--   handler_opts = {
--     border = "rounded",
--   },
--   always_trigger = true,
-- }

-- vim.diagnostic.config({
--   virtual_text = true,
--   signs = true,
--   update_in_insert = false,
--   underline = true,
--   severity_sort = true,
--   float = true,
-- })

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
		-- Auto-format ("lint") on save.
		-- Usually not needed if server supports "textDocument/willSaveWaitUntil".
		if
				not client:supports_method("textDocument/willSaveWaitUntil")
				and client:supports_method("textDocument/formatting")
		then
			vim.api.nvim_create_autocmd("BufWritePre", {
				group = vim.api.nvim_create_augroup("my.lsp", { clear = false }),
				buffer = args.buf,
				callback = function()
					vim.lsp.buf.format({ bufnr = args.buf, id = client.id, timeout_ms = 1000 })
				end,
			})
		end
	end,
})
