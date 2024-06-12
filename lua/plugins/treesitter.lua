-- https://github.com/nvim-treesitter/nvim-treesitter

return {
	"nvim-treesitter/nvim-treesitter",
	build = function() require("nvim-treesitter.install").update({ with_sync = true })() end,
	init = function()
		vim.cmd([[set foldmethod=expr]])
		vim.cmd([[set foldexpr=nvim_treesitter#foldexpr()]])
	end,
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
				enabled = true,
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
