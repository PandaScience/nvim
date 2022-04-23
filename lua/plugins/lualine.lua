local gps = require("nvim-gps")

require('lualine').setup{
	options = {
		-- theme = 'sonokai'
		-- theme = 'sonokai'
		-- theme = 'onedark'
		component_separators = { left = '', right = '' },
		section_separators = { left = '', right = '' },
	},

	sections = {
		lualine_c = {
			{ gps.get_location, cond = gps.is_available },
		}
	},

	-- tabline = {
	-- 	lualine_a = {'buffers'},
	-- 	lualine_b = {''},
	-- 	lualine_c = {''},
	-- 	lualine_x = {},
	-- 	lualine_y = {},
	-- 	lualine_z = {''}
	-- },
}
