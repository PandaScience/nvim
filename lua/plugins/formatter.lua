-- https://github.com/mhartington/formatter.nvim

local util = require("formatter.util")

-- https://github.com/mhartington/formatter.nvim/tree/master/lua/formatter/filetypes
require("formatter").setup({
	filetype = {
		lua = {
			-- https://www.reddit.com/r/neovim/comments/vtdmry/stylua_now_supports_collapsing_simple_statements/
			function()
				f = require("formatter.filetypes.lua").stylua()
				table.insert(f.args, 1, "--collapse-simple-statement='Always'")
				return f
			end,
		},
		markdown = {
			require("formatter.filetypes.markdown").prettierd,
		},
		yaml = {
			require("formatter.filetypes.yaml").prettierd,
		},
		json = {
			require("formatter.filetypes.json").prettierd,
		},
		jsonc = {
			function()
				return {
					exe = "prettier",
					args = {
						"--trailing-comma none",
						"--stdin-filepath",
						util.escape_path(util.get_current_buffer_file_path()),
					},
					stdin = true,
				}
			end,
		},
		css = {
			require("formatter.filetypes.css").prettierd,
		},
		c = {
			require("formatter.filetypes.c").clangformat,
		},
		["*"] = {
			require("formatter.filetypes.any").remove_trailing_whitespace,
		},
	},
})

-- NOTE: autoformat-on-save augroup defined in core/autocmds.lua
