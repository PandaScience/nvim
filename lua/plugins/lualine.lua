-- https://github.com/nvim-lualine/lualine.nvim

local navic = require("nvim-navic")

require("lualine").setup({
	options = {
		-- theme = 'sonokai'
		-- theme = 'sonokai'
		-- theme = 'onedark'
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

	-- tabline = {
	-- 	lualine_a = {'buffers'},
	-- 	lualine_b = {''},
	-- 	lualine_c = {''},
	-- 	lualine_x = {},
	-- 	lualine_y = {},
	-- 	lualine_z = {''}
	-- },
})
