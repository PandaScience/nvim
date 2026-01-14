-- https://github.com/stevearc/conform.nvim
-- injected language formatting: https://github.com/stevearc/conform.nvim/blob/master/doc/advanced_topics.md#injected-language-formatting-code-blocks

return {
	"stevearc/conform.nvim",
	dependencies = { "WhoIsSethDaniel/mason-tool-installer.nvim" },
	init = function()
		-- use this instead of format_on_save if formatting changes should not be written to disk
		vim.api.nvim_create_autocmd("BufWritePost", {
			desc = "Auto format files w/o saving changes to disk",
			callback = function(args)
				-- command works as expected when run via :lua conform.format() but not as aucmd.
				-- reason probably is execution context. nvim is still finishing the "save" event
				-- loop, sees the new dirty buffer and immediately synchronizes the new changes.
				-- we postpone the formatting via vim.schedule() to be invoked in the main event
				-- loop AFTER the save process has been completely finished.
				vim.schedule(function()
					-- skip if buffer does not exist anymore or is no "normal file", like quickfix windows etc.
					if not vim.api.nvim_buf_is_valid(args.buf) or vim.bo[args.buf].buftype ~= "" then return end
					require("conform").format(
						{ bufnr = args.buf, async = true, lsp_format = "fallback" },
						function(err, did_edit)
							if err then
								vim.notify("Formatting error: " .. err, vim.log.levels.ERROR)
							elseif did_edit then
								vim.notify("Auto-format triggered - buffer dirty!", vim.log.levels.WARN)
							end
						end
					)
				end)
			end,
		})
	end,
	config = function()
		local conform = require("conform")

		conform.formatters.stylua = {
			prepend_args = { "--collapse-simple-statement", "Always" },
		}

		conform.setup({
			formatters_by_ft = {
				sh = { "shfmt" },
				lua = { "stylua" },
				css = { "prettierd" },
				markdown = { "prettierd" },
				yaml = { "prettierd" },
				json = { "prettierd" },
				typescript = { "prettierd" },
				c = { "clang-format" },
				python = { "isort", "black" },
				-- Use the "*" filetype to run formatters on all filetypes.
				-- ["*"] = { "codespell" },
				-- Use the "_" filetype to run formatters on filetypes that don't
				-- have other formatters configured.
				["_"] = { "trim_whitespace", "trim_newlines" },
			},
		})
	end,
}
