-- https://github.com/williamboman/mason.nvim
-- https://github.com/williamboman/mason-lspconfig.nvim
-- https://github.com/neovim/nvim-lspconfig

local config = function()
	-- advertise nvim-cmp capabilities to LSPs
	local capabilities = require("cmp_nvim_lsp").default_capabilities()

	vim.lsp.config("*", {
		capabilities = capabilities,
	})

	-- simple lsp configs
	vim.lsp.enable("pyright")
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

	-- BUG: [ERROR][2025-09-19 20:32:26] ...p/_transport.lua:36	"rpc"	"ltex-ls"	"stderr"	"Error: JAVA_HOME is not defined correctly.\n  We cannot execute \n"
	-- --- ltex user dictionary:
	-- local path = vim.fn.stdpath("config") .. "/spell/en.utf-8.add"
	-- local words = {}
	-- for word in io.open(path, "r"):lines() do
	-- 	table.insert(words, word)
	-- end
	-- vim.lsp.config["ltex"] = {
	-- 	filetypes = { "markdown", "text", "gitcommit" },
	-- 	autostart = false,
	-- 	settings = {
	-- 		ltex = {
	-- 			dictionary = {
	-- 				["en-US"] = words,
	-- 			},
	-- 		},
	-- 	},
	-- }
	-- vim.lsp.enable("ltex")

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

	-- autoformat if LSP supports it
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
	{
		"williamboman/mason.nvim",
		config = true,
	},
	{
		"williamboman/mason-lspconfig.nvim",
		config = true,
		opts = {
			ensure_installed = {
				"lua_ls",
				"pyright",
				"marksman",
				"yamlls",
				"ltex",
				"tflint",
				"terraformls",
				"ansiblels",
				"gopls",
				"kcl",
			},
			automatic_installation = true,
		},
	},
	{
		"neovim/nvim-lspconfig",
		event = { "BufReadPre", "BufNewFile" },
		dependencies = "hrsh7th/nvim-cmp",
		config = config,
		keys = {
			-- from readme
			{ "<space>e", vim.diagnostic.open_float },
			{ "[d", vim.diagnostic.goto_prev },
			{ "]d", vim.diagnostic.goto_next },
			{ "<space>q", vim.diagnostic.setloclist },
			-- own additions
			{ "<leader><leader>f", function() vim.lsp.buf.format({ async = true }) end },
			{ "ff", function() vim.lsp.buf.formatexpr() end, mode = "v" },
			{
				"<C-space>",
				function() vim.diagnostic.open_float({ scope = "line", border = "rounded", focusable = false }) end,
			},
		},
	},
}
