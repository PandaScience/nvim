-- https://github.com/romus204/tree-sitter-manager.nvim

return {
	"romus204/tree-sitter-manager.nvim",
	dependencies = {}, -- tree-sitter CLI must be installed system-wide
	config = function()
		require("tree-sitter-manager").setup({
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
			auto_install = true,
		})
	end,
}
