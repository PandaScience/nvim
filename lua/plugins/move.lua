-- https://github.com/matze/vim-move

return {
	"matze/vim-move",
	-- NOTE: this is a vimscript plugin, so no setup() function!
	config = function()
		local map = vim.keymap.set
		map("n", "<A-Up>", "<Plug>MoveLineUp")
		map("n", "<A-Down>", "<Plug>MoveLineDown")
		map("n", "<A-Left>", "<Plug>MoveCharLeft")
		map("n", "<A-Right>", "<Plug>MoveCharRight")
		map("v", "<A-Up>", "<Plug>MoveBlockUp")
		map("v", "<A-Down>", "<Plug>MoveBlockDown")
		map("v", "<A-Left>", "<Plug>MoveBlockLeft")
		map("v", "<A-Right>", "<Plug>MoveBlockRight")
	end,
}
