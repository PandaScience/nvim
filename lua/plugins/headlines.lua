-- https://github.com/lukas-reineke/headlines.nvim
-- https://riptutorial.com/lua/example/20315/lua-pattern-matching

return {
	"lukas-reineke/headlines.nvim",
	dependencies = "nvim-treesitter/nvim-treesitter",
	init = function()
		vim.cmd([[highlight Headline1 guibg=#1e2718]])
		vim.cmd([[highlight Headline2 guibg=#21262d]])
		vim.cmd([[highlight CodeBlock guibg=#1c1c1c]])
		vim.cmd([[highlight Dash guibg=#222222]])
	end,
	opts = {
		markdown = {
			headline_highlights = { "Headline1", "Headline2" },
		},
		python = {
			-- HACK: lua patterns have no 'alternation' concept, so highlight all
			-- HACK: lines starting with caps like NOTE, BUG, etc.
			headline_pattern = "^# %u+",
			headline_highlights = { "Headline2" },
			fat_headlines = false,
		},
	},
}
