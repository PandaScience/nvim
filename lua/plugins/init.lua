-- bootstrap code, see https://github.com/wbthomason/packer.nvim#bootstrapping
local fn = vim.fn
local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'
if fn.empty(fn.glob(install_path)) > 0 then
	packer_bootstrap = fn.system({
		'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim',
		install_path
	})
	print 'Installing packer'

	-- required because we use bootstrap within a module
	vim.cmd [[packadd packer.nvim]]
end


function get_config(name)
	return string.format('require("plugins/%s")', name)
end


return require('packer').startup({function(use)
	-- let packer manage itself
	use { 'wbthomason/packer.nvim' }
	-- speedup startup time
	use { 'lewis6991/impatient.nvim' }

	-- general settings
	use { 'tpope/vim-sensible' }
	use { 'tpope/vim-sleuth' }
	use { 'lambdalisue/suda.vim', config = 'vim.g.suda_smart_edit = 1' }

	-- colorscheme
	use { 'olimorris/onedarkpro.nvim', config = get_config('onedark-pro') }

	-- ui
	use { 'kyazdani42/nvim-web-devicons' } -- required by many other plugins
	use { 'mhinz/vim-startify' }
	use { 'mbbill/undotree' }
	use { 'liuchengxu/vista.vim' }
	use { 'voldikss/vim-floaterm', config = function() vim.g.floaterm_keymap_toggle = '<F12>' end }
	use { 'kyazdani42/nvim-tree.lua', config = function() require('nvim-tree').setup() end }
	use { 'nvim-lualine/lualine.nvim', config = get_config('lualine') }
	-- use { 'tamton-aquib/staline.nvim', config = get_config('staline') }
	-- use { 'romgrk/barbar.nvim', config = get_config('barbar') }
	use { 'akinsho/bufferline.nvim', tag = "*", config = get_config('bufferline') }

	-- easy typing helpers
	use { 'tpope/vim-abolish' }
	use { 'tpope/vim-surround' }
	use { 'tpope/vim-repeat' }
	use { 'jiangmiao/auto-pairs' }
	use { 'alvan/vim-closetag' }
	use { 'junegunn/vim-easy-align', config = get_config('easy_align') }
	use { 'numToStr/Comment.nvim', config = function() require('Comment').setup() end }
	use { 'matze/vim-move' }

	-- search and motion
	use { 'ibhagwan/fzf-lua', config = get_config('fzf-lua') } -- requires fzf to be installed on system!
	use { 'ggandor/lightspeed.nvim' }

	-- syntax and formatting
	use { 'williamboman/nvim-lsp-installer' }
	use { 'neovim/nvim-lspconfig', config = get_config('lsp') }
	use { "folke/trouble.nvim", config = get_config('trouble') }
	use { 'nvim-treesitter/nvim-treesitter', run = ':TSUpdate', config = get_config('treesitter') }
	use { 'nvim-treesitter/playground', cmd = 'TSPlaygroundToggle'}
	use { 'lukas-reineke/indent-blankline.nvim', config = get_config('indent_blankline') }
	use { 'SmiteshP/nvim-gps', config = function() require('nvim-gps').setup() end }
	use { 'axelf4/vim-strip-trailing-whitespace' }
	use { 'norcalli/nvim-colorizer.lua', config = function() require('colorizer').setup() end }
	use {
		'folke/todo-comments.nvim', config = function() require("todo-comments").setup() end,
		requires = "nvim-lua/plenary.nvim",
	}

	-- HACK: requied because of buggy/WIP treesitter indentation
	use { 'yioneko/nvim-yati',
		config = function() require("nvim-treesitter.configs").setup{ yati = { enable = true } } end
	}

	-- NOTE: required for tf syntax highlighting eventhough treesitter server is available...
	use { 'hashivim/vim-terraform', config = get_config('terraform') }

	-- completion
	use { 'hrsh7th/vim-vsnip' }
	use { 'hrsh7th/vim-vsnip-integ' }
	use { 'hrsh7th/cmp-nvim-lsp' }
	use { 'hrsh7th/cmp-buffer' }
	use { 'hrsh7th/cmp-path' }
	use { 'hrsh7th/cmp-cmdline' }
	use { 'hrsh7th/nvim-cmp', config = get_config('cmp') }
	use { 'folke/which-key.nvim', config = function() require("which-key").setup {} end }

	-- git integration
	use { 'rhysd/committia.vim' }
	use { 'lewis6991/gitsigns.nvim', config = function() require('gitsigns').setup() end }
	use { 'tpope/vim-fugitive' }
	-- use { 'TimUntersberger/neogit', cmd = 'Neogit', config = function() require('neogit').setup() end }
	use { 'jreybert/vimagit' }

	-- language specific plugins
	use { 'lervag/vimtex' }
	use { 'fladson/vim-kitty' }
	use { 'ellisonleao/glow.nvim' }
	use { "iamcco/markdown-preview.nvim", run = function() vim.fn["mkdp#util#install"]() end }

	if packer_bootstrap then
		require('packer').sync()
	end
end,

-- open packer in floating window on first startup
config = {
	display = {
		open_fn = function()
			return require('packer.util').float({ border = 'single' })
		end
	}
}})
