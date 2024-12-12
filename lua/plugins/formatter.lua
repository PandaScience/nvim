-- https://github.com/mhartington/formatter.nvim

return {
	"mhartington/formatter.nvim",
	lazy = false,
	init = function()
		-- https://github.com/mhartington/formatter.nvim?tab=readme-ov-file#beforeafter-format-hooks
		vim.api.nvim_create_autocmd("BufWritePost", {
			desc = "Auto format files with `formatter` w/o saving if available",
			command = "FormatLock",
			group = vim.api.nvim_create_augroup("autoformatOnSave", { clear = true }),
		})
	end,
	-- BUG: ? https://github.com/mhartington/formatter.nvim/issues/286
	-- -> use config instead of opts to prevent `missing module` errors b/c of `require` statements
	config = function()
		local opts = {
			-- https://github.com/mhartington/formatter.nvim/tree/master/lua/formatter/filetypes
			filetype = {
				sh = {
					require("formatter.filetypes.sh").shfmt,
				},
				lua = {
					-- https://www.reddit.com/r/neovim/comments/vtdmry/stylua_now_supports_collapsing_simple_statements/
					function()
						f = require("formatter.filetypes.lua").stylua()
						table.insert(f.args, 1, "--collapse-simple-statement='Always'")
						return f
					end,
				},
				css = {
					require("formatter.filetypes.css").prettierd,
				},
				markdown = {
					require("formatter.filetypes.markdown").prettierd,
				},
				yaml = {
					require("formatter.filetypes.yaml").yamlfmt,
				},
				["yaml.ansible"] = {
					require("formatter.filetypes.yaml").prettierd,
				},
				json = {
					require("formatter.filetypes.json").prettierd,
				},
				jsonc = {
					function()
						local util = require("formatter.util")
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
				c = {
					require("formatter.filetypes.c").clangformat,
				},
				python = {
					require("formatter.filetypes.python").black,
				},
				["*"] = {
					require("formatter.filetypes.any").remove_trailing_whitespace,
				},
			},
		}

		require("formatter").setup(opts)
	end,
	keys = {
		{ "<leader><leader>F", "<cmd>Format<cr>", desc = "Format the file using formatter.nvim" },
	},
}
