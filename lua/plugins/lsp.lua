-- https://github.com/williamboman/mason.nvim
-- https://github.com/williamboman/mason-lspconfig.nvim
-- https://github.com/neovim/nvim-lspconfig

-- Use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer
local on_attach = function(client, bufnr)
	-- Enable completion triggered by <c-x><c-o>
	vim.api.nvim_buf_set_option(bufnr, "omnifunc", "v:lua.vim.lsp.omnifunc")

	-- Mappings.
	-- See `:help vim.lsp.*` for documentation on any of the below functions
	local bufopts = { noremap = true, silent = true, buffer = bufnr }
	vim.keymap.set("n", "gD", vim.lsp.buf.declaration, bufopts)
	vim.keymap.set("n", "gd", vim.lsp.buf.definition, bufopts)
	vim.keymap.set("n", "K", vim.lsp.buf.hover, bufopts)
	vim.keymap.set("n", "gi", vim.lsp.buf.implementation, bufopts)
	vim.keymap.set("n", "<C-k>", vim.lsp.buf.signature_help, bufopts)
	vim.keymap.set("n", "<space>wa", vim.lsp.buf.add_workspace_folder, bufopts)
	vim.keymap.set("n", "<space>wr", vim.lsp.buf.remove_workspace_folder, bufopts)
	vim.keymap.set("n", "<space>wl", function() print(vim.inspect(vim.lsp.buf.list_workspace_folders())) end, bufopts)
	vim.keymap.set("n", "<space>D", vim.lsp.buf.type_definition, bufopts)
	vim.keymap.set("n", "<space>rn", vim.lsp.buf.rename, bufopts)
	vim.keymap.set("n", "<space>ca", vim.lsp.buf.code_action, bufopts)
	vim.keymap.set("n", "gr", vim.lsp.buf.references, bufopts)
	vim.keymap.set("n", "<space>f", function() vim.lsp.buf.format({ async = true }) end, bufopts)
end

local config = function()
	local lspconfig = require("lspconfig")
	local capabilities = require("cmp_nvim_lsp").default_capabilities()

	-- simple lsp configs
	lspconfig.pyright.setup({ on_attach = on_attach, capabilities = capabilities })
	lspconfig.marksman.setup({ on_attach = on_attach, capabilities = capabilities })
	lspconfig.tflint.setup({ on_attach = on_attach, capabilities = capabilities })

	-- terraform
	lspconfig.terraformls.setup({
		on_init = function(client, _)
			-- turn off semantic tokens -> highlighting only via treesitter grammar
			client.server_capabilities.semanticTokensProvider = nil
		end,
		on_attach = on_attach,
		capabilities = capabilities,
	})

	--- ltex user dictionary:
	local path = vim.fn.stdpath("config") .. "/spell/en.utf-8.add"
	local words = {}
	for word in io.open(path, "r"):lines() do
		table.insert(words, word)
	end
	lspconfig.ltex.setup({
		on_attach = on_attach,
		filetypes = { "markdown", "text", "gitcommit" },
		settings = {
			ltex = {
				dictionary = {
					["en-US"] = words,
				},
			},
		},
	})

	-- https://www.reddit.com/r/neovim/comments/ze9gbe/kubernetes_auto_completion_support_in_neovim/
	-- https://www.arthurkoziel.com/json-schemas-in-neovim/
	-- yamlls schemas from store, matched by filename, loaded automatically
	local yaml_schemas = {
		kubernetes = "*.yaml",
		["https://json.schemastore.org/github-workflow"] = ".github/workflows/*",
		["https://json.schemastore.org/github-action"] = ".github/action.{yml,yaml}",
		["https://json.schemastore.org/ansible-stable-2.9"] = "roles/tasks/*.{yml,yaml}",
		["https://json.schemastore.org/prettierrc"] = ".prettierrc.{yml,yaml}",
		["https://json.schemastore.org/kustomization"] = "kustomization.{yml,yaml}",
		["https://json.schemastore.org/ansible-playbook"] = "*play*.{yml,yaml}",
		["https://json.schemastore.org/chart"] = "Chart.{yml,yaml}",
		["https://json.schemastore.org/dependabot-v2"] = ".github/dependabot.{yml,yaml}",
		["https://json.schemastore.org/gitlab-ci"] = "*gitlab-ci*.{yml,yaml}",
		["https://raw.githubusercontent.com/OAI/OpenAPI-Specification/main/schemas/v3.1/schema.json"] = "*api*.{yml,yaml}",
		["https://raw.githubusercontent.com/compose-spec/compose-spec/master/schema/compose-spec.json"] = "*docker-compose*.{yml,yaml}",
		["https://raw.githubusercontent.com/argoproj/argo-workflows/master/api/jsonschema/schema.json"] = "*flow*.{yml,yaml}",
	}
	local yaml_opts = {
		on_attach = on_attach,
		capabilities = capabilities,
		settings = {
			yaml = {
				-- only enable explicitly configured schemas from above
				schemastore = {
					enable = false,
					url = "",
				},
				schemas = yaml_schemas,
			},
		},
	}
	lspconfig.yamlls.setup(yaml_opts)

	-- autoformat if LSP supports it
	vim.api.nvim_create_autocmd("BufWritePre", {
		buffer = buffer,
		callback = function() vim.lsp.buf.format({ async = true }) end,
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
			ensure_installed = { "pyright", "marksman", "yamlls", "ltex", "tflint", "terraformls" },
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
