-- https://github.com/mfussenegger/nvim-lint
-- https://github.com/rshkarin/mason-nvim-lint

return {
	"mfussenegger/nvim-lint",
	dependencies = { "WhoIsSethDaniel/mason-tool-installer.nvim" },
	config = function()
		-- disable inline diagnostics: https://github.com/mfussenegger/nvim-lint/issues/124
		vim.diagnostic.config({ virtual_text = false })

		-- run linter on text changes and buffer writes
		vim.api.nvim_create_autocmd({ "BufWritePost", "TextChanged" }, {
			pattern = "<buffer>",
			callback = function() require("lint").try_lint() end,
			group = vim.api.nvim_create_augroup("LintAfterWrite", { clear = true }),
		})

		-- linter configs
		require("lint").linters_by_ft = {
			sh = { "shellcheck" },
			terraform = { "trivy" },
			yaml = { "trivy" },
		}
	end,
}
