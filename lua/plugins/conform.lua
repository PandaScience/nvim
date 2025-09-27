-- https://github.com/stevearc/conform.nvim
-- injected language formatting: https://github.com/stevearc/conform.nvim/blob/master/doc/advanced_topics.md#injected-language-formatting-code-blocks
return {
	"stevearc/conform.nvim",
	dependencies = { "WhoIsSethDaniel/mason-tool-installer.nvim" },
	config = function()
		local conform = require("conform")

		conform.formatters.stylua = {
			prepend_args = { "--collapse-simple-statement", "Always" },
		}

		conform.setup({
			log_level = vim.log.levels.DEBUG,
			-- https://github.com/stevearc/conform.nvim/issues/401#issuecomment-2108453243
			format_after_save = false,
			-- format_on_save = false,
			format_on_save = {
				timeout_ms = 500,
				lsp_format = "fallback",
			},
			formatters_by_ft = {
				sh = { "shfmt" },
				lua = { "stylua" },
				css = { "prettierd" },
				markdown = { "prettierd" },
				yaml = { "prettierd" },
				json = { "prettierd" },
				typescript = { "prettierd" },
				c = { "clangformat" },
				python = { "isort", "black" },
				-- Use the "*" filetype to run formatters on all filetypes.
				["*"] = { "codespell" },
				-- Use the "_" filetype to run formatters on filetypes that don't
				-- have other formatters configured.
				["_"] = { "trim_whitespace", "trim_newlines" },
			},
		})
	end,
}
