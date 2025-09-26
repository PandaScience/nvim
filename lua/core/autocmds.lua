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
-- fix terraform ,hcl and KCL-lang comment string
autocmd("FileType", {
	group = augroup("FixTerraformCommentString", {}),
	callback = function(ev) vim.bo[ev.buf].commentstring = "# %s" end,
	pattern = { "terraform", "hcl", "kcl" },
})

-- highlight trailing whitespace
-- src: https://github.com/hikaru-shindo/dotfiles/blob/main/nvim/dot-config/nvim/lua/hikaru-shindo/highlight.lua
vim.api.nvim_set_hl(0, "ExtraWhitespace", { ctermbg = "darkred", bg = "darkred" })
autocmd("BufWinEnter", {
	pattern = "*",
	callback = function(args)
		-- exclude helper buffers like blink completion pop-up
		if vim.bo[args.buf].buftype ~= "" then return end
		vim.fn.matchadd("ExtraWhitespace", [[\s\+$]])
	end,
})
