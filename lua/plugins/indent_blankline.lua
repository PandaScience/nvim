vim.g.indent_blankline_buftype_exclude = {
	"terminal",
	"nofile"
}

vim.g.indent_blankline_filetype_exclude = {
	"help",
	"startify",
	"dashboard",
	"packer",
	"neogitstatus",
	"NvimTree",
	"Trouble",
	"txt",
	"magit"
}

vim.g.indent_blankline_context_patterns = {
	-- defaults
	"class",
	"^func",
	"method",
	"^if",
	"while",
	"for",
	"with",
	"try",
	"except",
	"arguments",
	"argument_list",
	"object",
	"dictionary",
	"element",
	"table",
	"tuple",
	-- yaml
	"block",
}

require("indent_blankline").setup {
	space_char_blankline = " ",
	show_current_context = true,
	-- show_current_context_start = true,
}

vim.keymap.set('n', '<leader>i', '<cmd>IndentBlanklineToggle<CR>')
