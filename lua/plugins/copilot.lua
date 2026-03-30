-- https://github.com/zbirenbaum/copilot.lua
-- https://github.com/copilotlsp-nvim/copilot-lsp

local copilot = {
	"zbirenbaum/copilot.lua",
	dependencies = {
		{ "copilotlsp-nvim/copilot-lsp", init = function() vim.g.copilot_nes_debounce = 500 end },
		"AndreM222/copilot-lualine", -- (optional) for LuaLine integration
	},
	cmd = "Copilot",
	event = "InsertEnter",
	-- init = function()
	-- 	BUG: this is not working currently!
	-- 	vim.api.nvim_create_autocmd("User", {
	-- 		pattern = "BlinkCmpMenuOpen",
	-- 		callback = function() vim.b.copilot_suggestion_hidden = true end,
	-- 	})
	-- 	vim.api.nvim_create_autocmd("User", {
	-- 		pattern = "BlinkCmpMenuClose",
	-- 		callback = function() vim.b.copilot_suggestion_hidden = false end,
	-- 	})
	-- end,
	opts = {
		panel = {
			enabled = false,
		},
		suggestion = {
			enabled = true,
			auto_trigger = true,
			keymap = {
				accept = "<S-Right>",
				accept_word = "<C-Right>",
				next = "<M-]>",
				prev = "<M-[>",
				dismiss = "<C-E>",
			},
		},

		nes = {
			enabled = false,
			-- BUG: disabling does not work!
			auto_trigger = false,
			-- NOTE: this would only set keymaps for normal mode, but we want insert mode shortcuts!
			keymap = {
				accept = "<C-Up>",
				accept_and_goto = "<C-Down>",
				dismiss = "<Esc>",
			},
		},

		filetypes = {
			yaml = true,
			markdown = true,
			gitcommit = true,
			sh = function()
				local fname = vim.fs.basename(vim.api.nvim_buf_get_name(0))
				if string.match(fname, "^%.env.*") then return false end
				return true
			end,
			toml = function()
				local fname = vim.fs.basename(vim.api.nvim_buf_get_name(0))
				if string.match(fname, "^%.?mise%.local%.toml$") then return false end
				return true
			end,
		},
	},
}

return {
	copilot,
}
