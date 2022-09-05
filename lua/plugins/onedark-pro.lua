vim.o.background = "dark"

local onedarkpro = require("onedarkpro")

onedarkpro.setup({
	theme = 'onedark',-- onedark | onelight | onedark_vivid

	colors = {}, -- Override default colors by specifying colors for 'onelight' or 'onedark' themes
	ft_highlights = {}, -- Override default highlight groups for specific filetypes
	highlights = { -- Override default highlight groups
		-- better contrast in visual selection
		Visual = { style = 'reverse' },
		-- better contrast for floating windows
		FloatBorder = { fg = '${orange}', bg = 'NONE'},
		-- control characters (like ^M)
		SpecialKey = { fg = '#FF0000', bg = 'NONE', style = "bold" },
		-- listchars (see :h listchars) (leading tab chars not visible when using IndentBlankline)
		NonText = { link = "Whitespace" },  -- eol, extends, precedes
		Whitespace = { link = "Whitespace" },  -- nbsp, space, tab, multispace, lead, trail
		-- plugin override (see :h hl-IndentBlanklineSpaceChar) (tab symbol if no other char comes before)
		IndentBlanklineSpaceChar = { fg = '#555555', bg = 'NONE' }, -- tab and space indents
		-- make non-active (treesitter) indent lines less visible
		IndentBlanklineChar = { fg = '#222222', bg = 'None' }
	},

	plugins = { -- Override which plugins highlight groups are loaded
		native_lsp = true,
		polygot = false,
		treesitter = true,
	},

	styles = {
		comments = "italic",
		functions = "NONE",
		keywords = "bold,italic",
		strings = "NONE",
		variables = "NONE",
		virtual_text = "NONE"
	},

	options = {
		bold = true, -- Use the themes opinionated bold styles?
		italic = true, -- Use the themes opinionated italic styles?
		underline = false, -- Use the themes opinionated underline styles?
		undercurl = true, -- Use the themes opinionated undercurl styles?
		cursorline = true, -- Use cursorline highlighting?
		transparency = true, -- Use a transparent background?
		terminal_colors = false, -- Use the theme's colors for Neovim's :terminal?
		window_unfocused_color = true, -- When the window is out of focus, change the normal background?
	},
})

onedarkpro.load()
