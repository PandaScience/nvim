-- https://github.com/lervag/vimtex

return {
	"lervag/vimtex",
	init = function() vim.g.vimtex_view_general_viewer = "mupdf" end,
	ft = "tex",
}
