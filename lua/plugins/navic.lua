-- https://github.com/SmiteshP/nvim-navic

return {
	"SmiteshP/nvim-navic",
	dependencies = "neovim/nvim-lspconfig",
	opts = {
		lsp = {
			auto_attach = true,
		},
		highlight = true,
	},
}
