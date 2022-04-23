-- use terraform-ls options --> :h :TerraformFmt
vim.g["terraform_fmt_on_save"] = true
vim.g["terraform_align"] = true

-- HACK: workaround
-- vim.cmd [[autocmd BufWritePre *tf lua vim.lsp.buf.formatting_sync()]]
