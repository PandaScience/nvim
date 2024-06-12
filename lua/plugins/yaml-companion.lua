-- https://github.com/someone-stole-my-name/yaml-companion.nvim

return {
	-- "someone-stole-my-name/yaml-companion.nvim", -- FIX: abandoned repo, broken for current nvim
	-- "hieulw/yaml-companion.nvim",
	"ohdearaugustin/yaml-companion.nvim",
	-- "vlada-dudr/yaml-companion.nvim",
	-- "msvechla/yaml-companion.nvim",
	-- branch = "kubernetes_crd_detection",
	requires = {
		{ "neovim/nvim-lspconfig" },
		{ "nvim-lua/plenary.nvim" },
		{ "nvim-telescope/telescope.nvim" },
	},
	lazy = false,
	config = function() require("telescope").load_extension("yaml_schema") end,
}
