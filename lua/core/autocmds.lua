local augroup = vim.api.nvim_create_augroup
local autocmd = vim.api.nvim_create_autocmd

-- NOTE: :help events

autocmd("VimResized", {
	group = augroup("ResizeSplits", {}),
	command = "silent! wincmd =",
	desc = "Auto-resize splits on host window size changes",
})

-- NOTE: must be aligned with the character setting in core/settings.lua
local hideLeadingSpaces = autocmd("Filetype", {
	group = augroup("hideLeadingSpaces", {}),
	pattern = "python",
	callback = function() vim.opt.listchars:remove("lead") end,
	desc = "Remove highlighting of leading spaces for filetypes with whitespace-only indents",
})
