require("fzf-lua").setup({
	-- on multiple selecte files, open all with enter
	-- https://github.com/ibhagwan/fzf-lua/issues/214
	files = {
		actions = {
			["default"] = require("fzf-lua.actions").file_edit,
		},
	},
})
