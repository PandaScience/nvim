local augroup = vim.api.nvim_create_augroup
local autocmd = vim.api.nvim_create_autocmd

-- NOTE: :help events

autocmd("VimResized", {
	group = augroup("ResizeSplits", {}),
	command = "silent! wincmd =",
	desc = "Auto-resize splits on host window size changes",
})
