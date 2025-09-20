-- https://github.com/williamboman/mason.nvim
-- https://github.com/williamboman/mason-lspconfig.nvim

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
			automatic_enable = false,
		},
	},
}
