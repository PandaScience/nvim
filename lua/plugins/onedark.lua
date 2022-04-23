require('onedark').setup{
	style = 'warmer', -- 'dark', 'darker', 'cool', 'deep', 'warm', 'warmer'
	transparent = true,
	term_colors = true,
	code_style = {
		comments = 'italic',
		keywords = 'none',
		functions = 'none',
		strings = 'none',
		variables = 'none'
    }
}

require('onedark').load()
