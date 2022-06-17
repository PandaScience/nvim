require("nvim-lsp-installer").setup {
	automatic_installation = true, -- automatically detect which servers to install (based on which servers are set up via lspconfig)
}

local lspconfig = require("lspconfig")

-- KEY MAPS --------------------------------------------------------------------
local map = vim.keymap.set
map('n', '<leader>ff', function() vim.lsp.buf.formatting() end)
map('v', 'ff', function() vim.lsp.buf.range_formatting() end)

map('n', '<C-space>', function() vim.diagnostic.open_float({scope='line', border='rounded', focusable=false}) end)

-- LSP server configs ----------------------------------------------------------
lspconfig.sumneko_lua.setup({
	settings = {
		Lua = {
			diagnostics = {
					-- surpress 'undefined global `vim`' warnings
					globals = { 'vim' }
			}
		}
	}
})

-- NOTE: enable mypy and black by pip-installing them into the respective
--			 venv in ~/.local/share/nvim/lsp_servers/pylsp
lspconfig.pylsp.setup({
	settings = {
		pylsp = {
			plugins = {
				pycodestyle = {
					-- disable some PEPs
					ignore = {"E501"},
				},
				black = {
					enabled = true,
					line_length = 100,
				}
			}
		}
	}
})

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.textDocument.completion.completionItem.snippetSupport = true
lspconfig.emmet_ls.setup({
		capabilities = capabilities,
		filetypes = { 'html', 'typescriptreact', 'javascriptreact', 'css', 'sass', 'scss', 'less' },
})


-- MISC ------------------------------------------------------------------------
-- disable inline diagnostics
-- https://github.com/neovim/nvim-lspconfig/issues/662
-- https://github.com/neovim/neovim/pull/12655
vim.diagnostic.config({virtual_text = false})
vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(
	vim.lsp.diagnostic.on_publish_diagnostics, {
		virtual_text = false,
		signs = true,
		update_in_insert = false,
		underline = true,
	}
)
