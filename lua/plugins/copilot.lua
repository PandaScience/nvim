-- https://github.com/zbirenbaum/copilot.lua
-- https://github.com/copilotlsp-nvim/copilot-lsp

return {
	{
		-- NOTE: requires copilot-lsp -> installed via mason
		"copilotlsp-nvim/copilot-lsp",
		init = function()
			vim.g.copilot_nes_debounce = 500
			vim.lsp.enable("copilot_ls")

			-- BUG: this is not working currently
			-- vim.keymap.set("n", "<esc>", function()
			-- 	if not require("copilot-lsp.nes").clear() then
			-- 		-- fallback to other functionality
			-- 	end
			-- end, { desc = "Clear Copilot suggestion or fallback" })

			vim.keymap.set({ "n", "i" }, "<C-i>", function()
				local bufnr = vim.api.nvim_get_current_buf()
				local state = vim.b[bufnr].nes_state
				if state then
					-- Try to jump to the start of the suggestion edit.
					-- If already at the start, then apply the pending suggestion and jump to the end of the edit.
					local _ = require("copilot-lsp.nes").walk_cursor_start_edit()
						or (
							require("copilot-lsp.nes").apply_pending_nes()
							and require("copilot-lsp.nes").walk_cursor_end_edit()
						)
					return nil
				end
			end, { desc = "Accept Copilot NES suggestion", expr = true })
		end,
		opts = {
			nes = {
				move_count_threshold = 3, -- clear after 3 cursor movements
			},
		},
	},
	{
		"zbirenbaum/copilot.lua",
		dependencies = {
			"copilotlsp-nvim/copilot-lsp", -- (optional) for NES functionality
			"AndreM222/copilot-lualine", -- (optional) for LuaLine integration
			"fang2hou/blink-copilot", -- (optional) for blink integration
		},
		cmd = "Copilot",
		event = "InsertEnter",
		init = function()
			-- BUG: this is not working currently!:w
			-- vim.api.nvim_create_autocmd("User", {
			-- 	pattern = "BlinkCmpMenuOpen",
			-- 	callback = function() vim.b.copilot_suggestion_hidden = true end,
			-- })
			-- vim.api.nvim_create_autocmd("User", {
			-- 	pattern = "BlinkCmpMenuClose",
			-- 	callback = function() vim.b.copilot_suggestion_hidden = false end,
			-- })
		end,
		opts = {
			panel = {
				enabled = false,
			},
			suggestion = {
				enabled = true,
				auto_trigger = true,
				keymap = {
					accept = "<Right>",
					next = "<C-]>",
					prev = "<C-[>",
					dismiss = "<C-E>",
				},
			},

			-- BUG: this is currently broken, configure NES directly in copilot-lsp
			-- nes = {
			-- 	enabled = true,
			-- 	auto_trigger = true,
			-- 	keymap = {
			-- 		accept_and_goto = "<Left>",
			-- 		-- accept = "<Left>",
			-- 		dismiss = "<Esc>",
			-- 	},
			-- },

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
	},
}
