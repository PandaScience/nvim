local augroup = vim.api.nvim_create_augroup
local autocmd = vim.api.nvim_create_autocmd

-- NOTE: :help events

autocmd("VimResized", {
	group = augroup("ResizeSplits", {}),
	command = "silent! wincmd =",
	desc = "Auto-resize splits on host window size changes",
})

autocmd("TextYankPost", {
	group = augroup("HighlightYankedText", {}),
	pattern = "*",
	callback = function() vim.highlight.on_yank({ higroup = "IncSearch", timeout = 350 }) end,
	desc = "Highlight selection on yank",
})

-- https://neovim.discourse.group/t/commentstring-for-terraform-files-not-set/4066/2
-- fix terraform and hcl comment string
autocmd("FileType", {
	group = augroup("FixTerraformCommentString", {}),
	callback = function(ev) vim.bo[ev.buf].commentstring = "# %s" end,
	pattern = { "terraform", "hcl" },
})
