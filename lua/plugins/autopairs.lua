-- https://github.com/altermo/ultimate-autopair.nvim
-- alternatives:
--   https://github.com/m4xshen/autoclose.nvim
--   https://github.com/windwp/nvim-autopairs
--   https://github.com/Saghen/blink.pairs

return {
	"altermo/ultimate-autopair.nvim",
	event = { "InsertEnter", "CmdlineEnter" },
	branch = "v0.6", --recommended as each new version will have breaking changes
	opts = {
		--Config goes here
	},
}
