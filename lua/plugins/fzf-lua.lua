-- https://github.com/ibhagwan/fzf-lua

-- NOTE: requires fzf to be installed on system but can then utilize a common config!
return {
	"ibhagwan/fzf-lua",
	dependencies = "nvim-tree/nvim-web-devicons",
	-- use function instead of opts b/c of `require` inside config
	config = function()
		require("fzf-lua").setup({
			-- on multiple selecte files, open all with enter
			-- https://github.com/ibhagwan/fzf-lua/issues/214
			files = {
				actions = {
					["default"] = require("fzf-lua.actions").file_edit,
				},
			},
		})
	end,
	keys = {
		{ "<C-p>", "<cmd>FzfLua files<CR>" },
		{ "<leader>z", "<cmd>FzfLua builtin<CR>" },
	},
}
