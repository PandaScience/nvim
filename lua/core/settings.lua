-- aliases as syntax reminder ;-)
local opt = vim.opt  -- global
local g   = vim.g    -- global for let options
local wo  = vim.wo   -- window local
local bo  = vim.bo   -- buffer local
local fn  = vim.fn   -- access vim functions
local cmd = vim.cmd  -- vim commands

-- set before lazy is loaded
vim.g.maplocalleader = ","

local options = {
	-- misc
	encoding       = "utf-8",
	spellfile      = vim.fn.stdpath("config") .. "/spell/en.utf-8.add",
	modeline       = true,
	modelines      = 2,
	modelineexpr   = false,
	-- ui
	winborder      = "rounded",
	termguicolors  = true,
	laststatus     = 2,
	showtabline    = 2,
	showmode       = false,
	colorcolumn    = '81,101,102,121,122,123',
	ruler          = false,
	number         = true,
	relativenumber = true,
	cursorline     = true,
	scrolloff      = 10,
	linebreak      = true,
	splitbelow     = true,
	splitright     = true,
	hidden         = true,
	mouse          = "a",
	wildmenu       = true,
	-- list chars
	list           = true,
	listchars      = { tab = '▸ ', nbsp = '⍽', extends = '❯', precedes = '❮'}, -- trail = '¬', eol = '@↴', space = '␣⋅'
	-- searching, see https://vim.fandom.com/wiki/Searching#Case_sensitivity
	hlsearch       = true,
	ignorecase     = true,
	smartcase      = true,
	-- tab stop config, see http://vim.wikia.com/wiki/Indent_with_tabs,_align_with_spaces
	expandtab      = false,
	copyindent     = true,
	preserveindent = true,
	softtabstop    = 0,
	shiftwidth     = 4,
	shiftround     = true,
	tabstop        = 4,
	autoindent     = true,
	foldlevel      = 20,
	-- handle undo, swap and backup paths, see https://jdhao.github.io/2019/11/16/nvim_file_backup/
	undofile       = true,
	backup         = true,
	writebackup    = true,
	backupskip     = "/tmp/*",
	backupdir      = vim.fn.stdpath("data") .. "/backup//",
	-- increment/decrement options for CTRL+A and CTRL-X
	nrformats      = 'alpha',
}

for k, v in pairs(options) do
	vim.opt[k] = v
end

-- disable builtins plugins
local disabled_builtins = {
	"netrw",
	"netrwPlugin",
	"netrwSettings",
	"netrwFileHandlers",
	"gzip",
	"zip",
	"zipPlugin",
	"tar",
	"tarPlugin",
	"getscript",
	"getscriptPlugin",
	"vimball",
	"vimballPlugin",
	"2html_plugin",
	"logipat",
	"rrhelper",
	"spellfile_plugin",
	"matchit"
}

for _, plugin in pairs(disabled_builtins) do
	-- wtf it is 1 instead of 0 to disable?
	vim.g["loaded_" .. plugin] = 1
end
