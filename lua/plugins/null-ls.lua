-- https://github.com/jose-elias-alvarez/null-ls.nvim
-- NOTE: binaries must be already present on the system!

local f = require("null-ls").builtins.formatting

local sources = {
	-- disabled completely b/c will ask on each file write which LSP to use for formatting
	-- all filetypes
	-- f.trim_newlines,
	-- f.trim_whitespace,  -- replaced by https://github.com/axelf4/vim-strip-trailing-whitespace

	-- python
	--  replaced by https://github.com/python-lsp/python-lsp-black
	-- f.black.with { extra_args = { "--fast", "--line-length=100" } },

	-- html, css, js and co.
	f.prettier.with { extra_args = { "--use-tabs" } },
}

-- https://github.com/jose-elias-alvarez/null-ls.nvim/wiki/Formatting-on-save
local augroup = vim.api.nvim_create_augroup("LspFormatting", {})
require("null-ls").setup({
	sources = sources,
	debug = false,

	-- you can reuse a shared lspconfig on_attach callback here
	on_attach = function(client, bufnr)
		if client.supports_method("textDocument/formatting") then
			vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
			vim.api.nvim_create_autocmd("BufWritePre", {
				group = augroup,
				buffer = bufnr,
				callback = function()
					-- on 0.8, you should use vim.lsp.buf.format({ bufnr = bufnr }) instead
					vim.lsp.buf.formatting()
				end,
			})
		end
	end,
})
