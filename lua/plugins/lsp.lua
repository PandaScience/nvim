require("nvim-lsp-installer").setup {
  automatic_installation = true, -- automatically detect which servers to install (based on which servers are set up via lspconfig)
}

local lspconfig = require("lspconfig")

lspconfig.sumneko_lua.setup {
  settings = {
    Lua = {
      diagnostics = {
          globals = { 'vim' }
      }
    }
  }
}

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
