-- https://github.com/lewis6991/gitsigns.nvim

return {
	"lewis6991/gitsigns.nvim",
	config = function()
		-- https://github.com/norcalli/nvim-colorizer.lua/issues/85
		require("gitsigns").setup({
			signs = {
				delete = { show_count = true },
				topdelete = { show_count = true },
			},
			numhl = false,
			linehl = false,
			word_diff = true,
		})
	end,
}
