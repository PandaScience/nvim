-- https://github.com/neovim/nvim-lspconfig

-- https://neovim.io/doc/user/lsp.html#_global-defaults
-- "gra"           Normal mode    vim.lsp.buf.code_action()
-- "gra"           Visual mode    vim.lsp.buf.code_action()
-- "gri"           Normal mode    vim.lsp.buf.implementation()
-- "grn"           Normal mode    vim.lsp.buf.rename()
-- "grr"           Normal mode    vim.lsp.buf.references()
-- "grt"           Normal mode    vim.lsp.buf.type_definition()
-- "gO"            Normal mode    vim.lsp.buf.document_symbol()
-- CTRL-S          Insert mode    vim.lsp.buf.signature_help()
-- K               Insert mode    vim.lsp.buf.hover()
-- CTRL-X_CTRL-O   Insert mode    vim.lsp.omnifunc()
-- "[d"            Normal mode    vim.diagnostic.jump({count = -1, float = true})
-- "]d"            Normal mode    vim.diagnostic.jump({count = +1, float = true})
-- NOTE: builtin "gd" for local and "gD" for global goto-declaration only searches for patterns without context-awareness!

local config = function()
	-- NOTE: not sure if still required for NVIM v0.11+ ...
	local capabilities = require("blink.cmp").get_lsp_capabilities()

	vim.lsp.config("*", {
		capabilities = capabilities,
	})

	-- simple lsp configs
	vim.lsp.enable("bashls")
	vim.lsp.enable("basedpyright")
	vim.lsp.enable("marksman")
	vim.lsp.enable("tflint")
	vim.lsp.enable("ansiblels")
	vim.lsp.enable("kcl")
	-- NOTE: autofmt is for rego is disabled below, b/c there is no option to set --v0-compatible in formatter
	vim.lsp.enable("regal")

	-- lua_ls
	vim.lsp.config["lua_ls"] = {
		settings = {
			Lua = {
				format = {
					enable = false,
				},
				workspace = {
					-- make `vim` global defined
					library = vim.api.nvim_get_runtime_file("", true),
				},
				telemetry = {
					enable = false,
				},
			},
		},
	}
	vim.lsp.enable("lua_ls")

	-- go please
	vim.lsp.config["gopls"] = {
		settings = {
			gopls = {
				analyses = {
					unusedvariables = true,
					unusedparams = true,
				},
				staticcheck = true,
				-- use stricter formatting
				gofumpt = true,
			},
		},
	}
	vim.lsp.enable("gopls")

	-- terraform
	vim.lsp.config["terraformls"] = {
		on_init = function(client, _)
			-- turn off semantic tokens -> highlighting only via treesitter grammar
			client.server_capabilities.semanticTokensProvider = nil
		end,
		on_attach = on_attach,
		capabilities = capabilities,
	}
	vim.lsp.enable("terraformls")

	vim.lsp.config["yamlls"] = {
		settings = {
			yaml = {
				hover = true,
				completion = true,
				validate = false,
				-- only enable explicitly configured schemas
				schemastore = {
					enable = false,
					url = "",
				},
				schemas = {
					kubernetes = "*.yaml",
				},
			},
		},
	}
	vim.lsp.enable("yamlls")

	-- autoformat if language server supports it
	vim.api.nvim_create_autocmd("BufWritePre", {
		buffer = buffer,
		-- no async here to prevent "buffer is not modifiable" error
		callback = function()
			-- exclude certain filetypes
			if vim.bo.filetype == "rego" then return end
			vim.lsp.buf.format({ async = false })
		end,
	})

	-- disable inline diagnostics: https://github.com/neovim/nvim-lspconfig/issues/662
	vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(vim.lsp.diagnostic.on_publish_diagnostics, {
		virtual_text = false,
		signs = true,
		update_in_insert = false,
		underline = true,
	})
end

return {
	"neovim/nvim-lspconfig",
	event = { "BufReadPre", "BufNewFile" },
	dependencies = {
		"hrsh7th/nvim-cmp",
		"WhoIsSethDaniel/mason-tool-installer.nvim",
	},
	config = config,
	keys = {
		-- from readme
		{ "<space>e", vim.diagnostic.open_float },
		{ "[d", vim.diagnostic.goto_prev },
		{ "]d", vim.diagnostic.goto_next },
		{ "<space>q", vim.diagnostic.setloclist },
		-- own additions
		{
			"<leader><leader>f",
			function() vim.lsp.buf.format({ async = true }) end,
		},
		{
			"ff",
			function() vim.lsp.buf.formatexpr() end,
			mode = "v",
		},
		{
			"<C-space>",
			function() vim.diagnostic.open_float({ scope = "line", border = "rounded", focusable = false }) end,
		},
	},
}
