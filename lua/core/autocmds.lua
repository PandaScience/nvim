local augroup = vim.api.nvim_create_augroup
local autocmd = vim.api.nvim_create_autocmd

-- NOTE: :help events

-- auto adjust splits on window resize
local resizeSplits = augroup("ResizeSplits", { clear = true })
autocmd("VimResized", {
	command = "silent! wincmd =",
	group = resizeSplits,
})

-- remove highlighted leading spaces for some filetypes that only use
-- whitespaces for indentation
-- NOTE: must be aligned with the character setting in core/settings.lua
local hideLeadingSpaces = augroup("hideLeadingSpaces", { clear = true })
autocmd("Filetype", {
	pattern = "python",
	callback = function() vim.opt.listchars:remove("lead") end,
	group = hideLeadingSpaces,
})
