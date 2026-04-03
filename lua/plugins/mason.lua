-- https://github.com/williamboman/mason.nvim
-- https://github.com/WhoIsSethDaniel/mason-tool-installer.nvim

return {
	{
		"williamboman/mason.nvim",
		config = true,
	},
	{
		"WhoIsSethDaniel/mason-tool-installer.nvim",
		dependencies = { "williamboman/mason.nvim" },
		config = true,
		opts = {
			ensure_installed = {
				-- NOTE: need to use mason package names which often differ from e.g. lspconfig names
				-- language server
				"copilot-language-server", -- configured in copilot.lua
				"bash-language-server", -- bashls
				"lua-language-server", -- lua_ls
				"basedpyright",
				"marksman",
				"yaml-language-server", -- yamlls
				"ltex-ls", -- ltex
				"tflint",
				"terraform-ls", -- terraformls
				{
					"gopls",
					condition = function() return vim.fn.executable("go") == 1 end,
				},
				"kcl",
			},
			auto_update = false,
		},
	},
}
