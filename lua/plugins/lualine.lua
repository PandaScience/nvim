-- https://github.com/nvim-lualine/lualine.nvim

return {
	"nvim-lualine/lualine.nvim",
	lazy = false,
	dependencies = {
		"nvim-tree/nvim-web-devicons",
		"SmiteshP/nvim-navic",
	},
	config = function()
		-- navic integration
		local navic = require("nvim-navic")

		-- trouble integration
		local trouble = require("trouble")
		local symbols = trouble.statusline({
			mode = "lsp_document_symbols",
			groups = {},
			title = false,
			filter = { range = true },
			format = "{kind_icon}{symbol.name:Normal}",
			-- The following line is needed to fix the background color
			-- Set it to the lualine section you want to use
			hl_group = "lualine_c_normal",
		})

		require("lualine").setup({
			options = {
				component_separators = { left = "", right = "" },
				section_separators = { left = "", right = "" },
			},
			sections = {
				lualine_c = {
					{
						symbols.get,
						symbols.has,
					},
				},
				lualine_d = {
					{
						function() return navic.get_location() end,
						cond = function() return navic.is_available() end,
					},
				},
			},
		})
	end,
}
