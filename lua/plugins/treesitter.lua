-- https://github.com/nvim-treesitter/nvim-treesitter

return {
	"nvim-treesitter/nvim-treesitter",
	build = ":TSUpdate",
	config = function()
		require("nvim-treesitter.configs").setup({
			sync_install = false,
			ensure_installed = {
				"bash",
				"c",
				"comment",
				"cpp",
				"css",
				"cuda",
				"dockerfile",
				"go",
				"hcl",
				"html",
				"javascript",
				"json",
				"kcl",
				"latex",
				"lua",
				"make",
				"markdown",
				"nix",
				"python",
				"query",
				"regex",
				"terraform",
				"typescript",
				"vim",
				"yaml",
			},
			highlight = {
				enable = true,
				disable = { "" },
				additional_vim_regex_highlighting = true,
			},
			indent = {
				enable = true,
				disable = { "yaml" },
			},
		})

		-- extend filetype association list
		vim.treesitter.language.register("bash", "zsh")
	end,
}
