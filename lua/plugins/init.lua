return {
	-- general settings
	"tpope/vim-sensible",
	"tpope/vim-sleuth",

	-- ui
	"mhinz/vim-startify",
	"mbbill/undotree",
	"liuchengxu/vista.vim",
	{ "voldikss/vim-floaterm", init = function() vim.g.floaterm_keymap_toggle = "<F12>" end },
	-- plugins/nvim-tree.lua   - "nvim-tree/nvim-tree.lua"
	-- plugins/lualine.lua     - "nvim-lualine/lualine.nvim"
	-- plugins/bufferline.lua  - "akinsho/bufferline.nvim"
	-- plugins/onedark-pro.lua - "olimorris/onedarkpro.nvim"

	-- easy typing helpers
	"tpope/vim-abolish",
	"tpope/vim-surround",
	"tpope/vim-repeat",
	"alvan/vim-closetag",
	{ "numToStr/Comment.nvim", config = function() require("Comment").setup() end },
	{ "karb94/neoscroll.nvim", opts = {} },
	-- plugins/move.lua - "matze/vim-move",
	-- plugins/align.lua - "junegunn/vim-easy-align"
	-- plugins/align.lua - "Vonr/align.nvim"

	-- search and motion
	-- plugins/telescope - "nvim-telescope/telescope.nvim"
	-- plugins/leap.lua  - "ggandor/leap.nvim"

	-- lsp, format, lint, grammar, debugger
	-- plugins/mason.lua      - "williamboman/mason.nvim"
	-- plugins/mason.lua      - "WhoIsSethDaniel/mason-tool-installer.nvim"
	-- plugins/lsp.lua        - "neovim/nvim-lspconfig"
	-- plugins/nvim-lint.lua  - "mfussenegger/nvim-lint"
	-- plugins/conform.lua    - "stevearc/conform"
	-- plugins/trouble.lua    - "folke/trouble.nvim"
	-- plugins/treesitter.lua - "nvim-treesitter/nvim-treesitter"
	-- plugins/dap.lua        - "mfussenegger/nvim-dap"

	-- other code helpers
	"HiPhish/rainbow-delimiters.nvim",
	{ "folke/todo-comments.nvim", config = true, dependencies = "nvim-lua/plenary.nvim" },
	{ "MeanderingProgrammer/render-markdown.nvim", ft = { "markdown", "codecompanion" } },
	-- plugins/indent_blankline.lua - "lukas-reineke/indent-blankline.nvim"
	-- plugins/colorizer.lua        - "norcalli/nvim-colorizer.lua"

	-- language specific plugins
	"kcl-lang/kcl.nvim",
	"fladson/vim-kitty",
	"mfussenegger/nvim-ansible",
	{ "ellisonleao/glow.nvim", config = true, cmd = "Glow" },
	-- plugins/markdown-preview.nvim - "iamcco/markdown-preview.nvim"
	-- plugins/vimtex.lua            - "lervag/vimtex"

	-- completion
	{ "folke/which-key.nvim", config = true },
	-- plugins/blink.lua - "saghen/blink.cmp",
	-- plugins/blink.lua - "rafamadriz/friendly-snippets"

	-- git integration
	"rhysd/committia.vim",
	"tpope/vim-fugitive",
	"jreybert/vimagit", -- TODO: switch to 'TimUntersberger/neogit' when matured
	-- plugins/gitsigns.lua - "lewis6991/gitsigns.nvim"

	-- AI
	-- plugins/copilot.lua - "zbirenbaum/copilot.lua"
	-- plugins/sidekick.lua - "folke/sidekick.nvim"
}
