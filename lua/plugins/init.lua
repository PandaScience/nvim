local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"https://github.com/folke/lazy.nvim.git",
		"--branch=stable", -- latest stable release
		lazypath,
	})
end
vim.opt.rtp:prepend(lazypath)

function get_config(name) return string.format('require("plugins/%s")', name) end

require("lazy").setup({
	-- general settings
	{ "tpope/vim-sensible" },
	{ "tpope/vim-sleuth" },
	{ "lambdalisue/suda.vim", init = function() vim.g.suda_smart_edit = 1 end },

	-- -- colorscheme
	-- { "olimorris/onedarkpro.nvim", priority = 1000, config = get_config("onedark-pro") },
	--
	-- -- ui
	-- { "kyazdani42/nvim-web-devicons" }, -- required by many other plugins
	-- { "mhinz/vim-startify" },
	-- { "mbbill/undotree" },
	-- { "liuchengxu/vista.vim" },
	-- { "voldikss/vim-floaterm", init = function() vim.g.floaterm_keymap_toggle = "<F12>" end },
	-- { "kyazdani42/nvim-tree.lua", config = function() require("nvim-tree").setup() end },
	-- { "nvim-lualine/lualine.nvim", config = get_config("lualine") },
	-- { "akinsho/bufferline.nvim", version = "*", config = get_config("bufferline") },
	--
	-- -- easy typing helpers
	-- { "tpope/vim-abolish" },
	-- { "tpope/vim-surround" },
	-- { "tpope/vim-repeat" },
	-- { "jiangmiao/auto-pairs" },
	-- { "alvan/vim-closetag" },
	-- { "junegunn/vim-easy-align", config = get_config("easy_align") },
	-- { "numToStr/Comment.nvim", config = function() require("Comment").setup() end },
	-- { "matze/vim-move" },
	--
	-- -- search and motion
	-- { "ibhagwan/fzf-lua", config = get_config("fzf-lua") }, -- requires fzf to be installed on system!
	-- { "ggandor/lightspeed.nvim" },
	--
	-- -- lsp
	-- { "williamboman/mason.nvim" },
	-- { "williamboman/mason-lspconfig.nvim" },
	-- { "neovim/nvim-lspconfig", config = get_config("lsp") },
	-- { "mhartington/formatter.nvim", config = get_config("formatter") },
	-- { "folke/trouble.nvim", config = get_config("trouble") },
	--
	-- -- treesitter and related
	-- { "nvim-treesitter/nvim-treesitter", run = ":TSUpdate", config = get_config("treesitter") },
	-- { "nvim-treesitter/playground", cmd = "TSPlaygroundToggle" },
	-- { "lukas-reineke/indent-blankline.nvim", main = "ibl", config = get_config("indent_blankline") },
	-- { "SmiteshP/nvim-navic", requires = "neovim/nvim-lspconfig" },
	--
	-- -- other syntax and formatting tools
	-- { "mfussenegger/nvim-lint", config = get_config("nvim-lint") },
	-- { "lukas-reineke/headlines.nvim", config = get_config("headlines") },
	-- { "norcalli/nvim-colorizer.lua", config = get_config("colorizer") },
	-- {
	-- 	"folke/todo-comments.nvim",
	-- 	config = function() require("todo-comments").setup() end,
	-- 	requires = "nvim-lua/plenary.nvim",
	-- },
	--
	-- -- language specific plugins
	-- { "lervag/vimtex" },
	-- { "fladson/vim-kitty" },
	-- { "ellisonleao/glow.nvim" },
	-- { "iamcco/markdown-preview.nvim", run = function() vim.fn["mkdp#util#install"]() end },
	-- -- NOTE: required for terraform syntax highlighting eventhough treesitter server is available...
	-- { "hashivim/vim-terraform", config = get_config("terraform") },
	--
	-- -- completion
	-- { "hrsh7th/vim-vsnip" },
	-- { "hrsh7th/vim-vsnip-integ" },
	-- { "hrsh7th/cmp-nvim-lsp" },
	-- { "hrsh7th/cmp-buffer" },
	-- { "hrsh7th/cmp-path" },
	-- { "hrsh7th/cmp-cmdline" },
	-- { "hrsh7th/nvim-cmp", config = get_config("cmp") },
	-- { "folke/which-key.nvim", config = function() require("which-key").setup({}, end },
	--
	-- -- git integration
	-- -- TODO switch to 'TimUntersberger/neogit' when matured
	-- { "rhysd/committia.vim" },
	-- { "lewis6991/gitsigns.nvim", config = function() require("gitsigns").setup() end },
	-- { "tpope/vim-fugitive" },
	-- { "jreybert/vimagit" },
})
