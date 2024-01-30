vim.cmd([[set foldmethod=expr]])
vim.cmd([[set foldexpr=nvim_treesitter#foldexpr()]])

local parser_config = require("nvim-treesitter.parsers").get_parser_configs()
parser_config.zimbu = {
	install_info = {
		url = "https://github.com/MichaHoffmann/tree-sitter-hcl", -- local path or git repo
		files = { "src/parser.c" },
		-- optional entries:
		branch = "main", -- default branch in case of git repo if different from master
		generate_requires_npm = false, -- if stand-alone parser without npm dependencies
		requires_generate_from_grammar = false, -- if folder contains pre-generated src/parser.c
	},
	filetype = "tf", -- if filetype does not match the parser name
}

-- extend filetype association list
vim.treesitter.language.register("bash", "zsh")

require("nvim-treesitter.configs").setup({
	sync_install = false,
	ensure_installed = {
		-- supported languages
		"bash",
		"comment",
		"css",
		"cuda",
		"dockerfile",
		"go",
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
		"typescript",
		"vim",
		"yaml",
		-- manual
		"hcl",
	},
	highlight = {
		enabled = true,
		disable = { "" },
		additional_vim_regex_highlighting = true,
	},
	indent = {
		enable = true,
	},

	-- taken from https://github.com/nvim-treesitter/playground#setup
	playground = {
		enable = true,
		disable = {},
		updatetime = 25, -- Debounced time for highlighting nodes in the playground from source code
		persist_queries = false, -- Whether the query persists across vim sessions
		keybindings = {
			toggle_query_editor = "o",
			toggle_hl_groups = "i",
			toggle_injected_languages = "t",
			toggle_anonymous_nodes = "a",
			toggle_language_display = "I",
			focus_language = "f",
			unfocus_language = "F",
			update = "R",
			goto_node = "<cr>",
			show_help = "?",
		},
	},
})
