return {
	-- general settings
	"tpope/vim-sensible",
	"tpope/vim-sleuth",
	{ "lambdalisue/suda.vim", init = function() vim.g.suda_smart_edit = 1 end },

	-- ui
	"mhinz/vim-startify",
	"mbbill/undotree",
	"liuchengxu/vista.vim",
	"kyazdani42/nvim-tree.lua",
	{ "voldikss/vim-floaterm", init = function() vim.g.floaterm_keymap_toggle = "<F12>" end },
	-- plugins/navic.lua       - "SmiteshP/nvim-navic"
	-- plugins/lualine.lua     - "nvim-lualine/lualine.nvim"
	-- plugins/bufferline.lua  - "akinsho/bufferline.nvim"
	-- plugins/onedark-pro.lua - "olimorris/onedarkpro.nvim"

	-- easy typing helpers
	"tpope/vim-abolish",
	"tpope/vim-surround",
	"tpope/vim-repeat",
	"jiangmiao/auto-pairs",
	"alvan/vim-closetag",
	{ "numToStr/Comment.nvim", config = function() require("Comment").setup() end },
	-- plugins/move.lua - "matze/vim-move",

	-- search and motion
	-- plugins/fzf-lua.lua - "ibhagwan/fzf-lua"
	-- plugins/leap.lua    - "ggandor/leap.nvim"

	-- lsp, format, lint, grammar
	-- plugins/lsp.lua        - "williamboman/mason.nvim"
	-- plugins/lsp.lua        - "williamboman/mason-lspconfig.nvim"
	-- plugins/lsp.lua        - "neovim/nvim-lspconfig"
	-- plugins/nvim-lint.lua  - "mfussenegger/nvim-lint"
	-- plugins/nvim-lint.lua  - "rshkarin/mason-nvim-lint"
	-- plugins/formatter.lua  - "mhartington/formatter.nvim"
	-- plugins/trouble.lua    - "folke/trouble.nvim"
	-- plugins/treesitter.lua - "nvim-treesitter/nvim-treesitter"

	-- other code helpers
	"HiPhish/rainbow-delimiters.nvim",
	{ "folke/todo-comments.nvim", config = true, dependencies = "nvim-lua/plenary.nvim" },
	-- plugins/indent_blankline.lua - "lukas-reineke/indent-blankline.nvim"
	-- plugins/headlines.lua        - "lukas-reineke/headlines.nvim"
	-- plugins/colorizer.lua        - "norcalli/nvim-colorizer.lua"

	-- language specific plugins
	"fladson/vim-kitty",
	{ "ellisonleao/glow.nvim", config = true, cmd = "Glow" },
	-- plugins/markdown-preview.nvim - "iamcco/markdown-preview.nvim"
	-- plugins/vimtex.lua            - "lervag/vimtex"

	-- completion
	{ "folke/which-key.nvim", config = true },
	-- plugins/cmp.lua - "hrsh7th/vim-vsnip"
	-- plugins/cmp.lua - "hrsh7th/vim-vsnip-integ"
	-- plugins/cmp.lua - "hrsh7th/cmp-nvim-lsp"
	-- plugins/cmp.lua - "hrsh7th/cmp-buffer"
	-- plugins/cmp.lua - "hrsh7th/cmp-path"
	-- plugins/cmp.lua - "hrsh7th/cmp-cmdline"
	-- plugins/cmp.lua - "hrsh7th/nvim-cmp"

	-- git integration
	"rhysd/committia.vim",
	"tpope/vim-fugitive",
	"jreybert/vimagit", -- TODO: switch to 'TimUntersberger/neogit' when matured
	{ "lewis6991/gitsigns.nvim", config = true },
}
