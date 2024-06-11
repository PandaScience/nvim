-- https://github.com/ggandor/leap.nvim

return {
	"ggandor/leap.nvim",
	-- NOTE: Using the keys feature of lazy.nvim might cause problems (see README)
	config = function()
		vim.keymap.set({ "n", "x", "o" }, "l", "<Plug>(leap-forward)")
		vim.keymap.set({ "n", "x", "o" }, "L", "<Plug>(leap-backward)")
		vim.keymap.set({ "n", "x", "o" }, "gl", "<Plug>(leap-from-window)")
	end,
}
