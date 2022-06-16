local nls = require("null-ls")
local b = nls.builtins

local sources = {
	b.formatting.prettier,
	b.formatting.black.with { extra_args = { "--fast", "--line-length=100" } },
}

nls.setup({
	sources = sources,
	debug = false,
})
