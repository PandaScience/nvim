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
          globals = { 'vim' }
      }
    }
  }
})

lspconfig.pylsp.setup {
  settings = {
    pylsp = {
      plugins = {
        pycodestyle = {
          ignore = {"E501"},
        }
      }
    }
  }
}
