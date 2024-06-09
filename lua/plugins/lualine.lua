-- https://github.com/nvim-lualine/lualine.nvim

return {
	"nvim-lualine/lualine.nvim",
	lazy = false,
	dependencies = {
		"nvim-tree/nvim-web-devicons",
		"SmiteshP/nvim-navic",
	},
	config = function()
		local navic = require("nvim-navic")
		require("lualine").setup({
			options = {
				component_separators = { left = "", right = "" },
				section_separators = { left = "", right = "" },
			},
			sections = {
				lualine_c = {
					{
						function() return navic.get_location() end,
						cond = function() return navic.is_available() end,
					},
				},
			},
		})
	end,
}
