-- https://github.com/junegunn/vim-easy-align
-- https://github.com/Vonr/align.nvim

return {
	{
		"junegunn/vim-easy-align",
		keys = {
			{ "ga", "<Plug>(LiveEasyAlign)", mode = "x" },
		},
	},
	{
		"Vonr/align.nvim",
		branch = "v2",
		keys = {
			{
				"aw",
				function()
					require("align").align_to_string({
						preview = true,
						regex = false,
					})
				end,
				mode = "x",
			},
		},
	},
}
