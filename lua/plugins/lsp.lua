-- https://github.com/williamboman/mason.nvim
-- https://github.com/williamboman/mason-lspconfig.nvim
-- https://github.com/neovim/nvim-lspconfig

require("mason").setup()
require("mason-lspconfig").setup({
	ensure_installed = { "lua_ls", "tsserver", "marksman", "yamlls", "ltex", "tflint", "pyright" },
	automatic_installation = true,
})

-- autoformat if LSP supports it
vim.api.nvim_create_autocmd("BufWritePre", {
	buffer = buffer,
	callback = function() vim.lsp.buf.format({ async = true }) end,
})

-- BEGIN suggested configuration

-- Mappings.
-- See `:help vim.diagnostic.*` for documentation on any of the below functions
local opts = { noremap = true, silent = true }
vim.keymap.set("n", "<space>e", vim.diagnostic.open_float, opts)
vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, opts)
vim.keymap.set("n", "]d", vim.diagnostic.goto_next, opts)
vim.keymap.set("n", "<space>q", vim.diagnostic.setloclist, opts)

-- Use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer
local on_attach = function(client, bufnr)
	-- Enable completion triggered by <c-x><c-o>
	vim.api.nvim_buf_set_option(bufnr, "omnifunc", "v:lua.vim.lsp.omnifunc")

	-- Mappings.
	-- See `:help vim.lsp.*` for documentation on any of the below functions
	local bufopts = { noremap = true, silent = true, buffer = bufnr }
	vim.keymap.set("n", "gD", vim.lsp.buf.declaration, bufopts)
	vim.keymap.set("n", "gd", vim.lsp.buf.definition, bufopts)
	vim.keymap.set("n", "K", vim.lsp.buf.hover, bufopts)
	vim.keymap.set("n", "gi", vim.lsp.buf.implementation, bufopts)
	vim.keymap.set("n", "<C-k>", vim.lsp.buf.signature_help, bufopts)
	vim.keymap.set("n", "<space>wa", vim.lsp.buf.add_workspace_folder, bufopts)
	vim.keymap.set("n", "<space>wr", vim.lsp.buf.remove_workspace_folder, bufopts)
	vim.keymap.set("n", "<space>wl", function() print(vim.inspect(vim.lsp.buf.list_workspace_folders())) end, bufopts)
	vim.keymap.set("n", "<space>D", vim.lsp.buf.type_definition, bufopts)
	vim.keymap.set("n", "<space>rn", vim.lsp.buf.rename, bufopts)
	vim.keymap.set("n", "<space>ca", vim.lsp.buf.code_action, bufopts)
	vim.keymap.set("n", "gr", vim.lsp.buf.references, bufopts)
	vim.keymap.set("n", "<space>f", function() vim.lsp.buf.format({ async = true }) end, bufopts)

	-- nvim-navic integration
	if client.server_capabilities.documentSymbolProvider then navic.attach(client, bufnr) end
end

local lsp_flags = {
	-- This is the default in Nvim 0.7+
	debounce_text_changes = 150,
}

-- END suggested configuration

-- ltex user dictionary:
-- https://www.reddit.com/r/neovim/comments/s24zvh/comment/hse4lrf/?utm_source=share&utm_medium=web2x&context=3
local path = vim.o.spellfile
local words = {}
for word in io.open(path, "r"):lines() do
	table.insert(words, word)
end

-- enable servers
require("lspconfig")["pyright"].setup({
	on_attach = on_attach,
	flags = lsp_flags,
})
require("lspconfig")["tsserver"].setup({
	on_attach = on_attach,
	flags = lsp_flags,
})
require("lspconfig")["marksman"].setup({
	on_attach = on_attach,
	flags = lsp_flags,
})
require("lspconfig")["yamlls"].setup({
	on_attach = on_attach,
	flags = lsp_flags,
})
require("lspconfig")["tflint"].setup({
	on_attach = on_attach,
	flags = lsp_flags,
})
require("lspconfig")["ltex"].setup({
	on_attach = on_attach,
	flags = lsp_flags,
	filetypes = { "markdown", "text", "gitcommit" },
	settings = {
		ltex = {
			dictionary = {
				["en-US"] = words,
			},
		},
	},
})

-- KEY MAPS --------------------------------------------------------------------
local map = vim.keymap.set
map("n", "<leader>ff", function() vim.lsp.buf.format({ async = true }) end)
map("v", "ff", function() vim.lsp.buf.formatexpr() end)
map(
	"n",
	"<C-space>",
	function() vim.diagnostic.open_float({ scope = "line", border = "rounded", focusable = false }) end
)

-- MISC ------------------------------------------------------------------------
-- disable inline diagnostics
-- https://github.com/neovim/nvim-lspconfig/issues/662
-- https://github.com/neovim/neovim/pull/12655
vim.diagnostic.config({ virtual_text = false })
vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(vim.lsp.diagnostic.on_publish_diagnostics, {
	virtual_text = false,
	signs = true,
	update_in_insert = false,
	underline = true,
})
