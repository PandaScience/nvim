local augroup = vim.api.nvim_create_augroup
local autocmd = vim.api.nvim_create_autocmd

-- auto adjust splits on window resize
local resizeSplits = augroup("ResizeSplits", { clear = true })
autocmd("VimResized", {
	command = "silent! wincmd =",
	group = resizeSplits,
})
