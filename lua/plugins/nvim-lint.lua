-- https://github.com/mfussenegger/nvim-lint.git

require('lint').linters_by_ft = {
	markdown = {'markdownlint',}
}

-- vim.cmd [[au BufWritePost <buffer> lua require('lint').try_lint()]]

local augroup = vim.api.nvim_create_augroup
local autocmd = vim.api.nvim_create_autocmd

local lintAfterWrite = augroup("LintAfterWrite", { clear = true })
autocmd("BufWritePost", {
	pattern = "<buffer>",
	callback = function() require('lint').try_lint() end,
	group = lintAfterWrite,
})
