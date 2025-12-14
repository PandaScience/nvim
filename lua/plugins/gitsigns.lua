-- https://github.com/lewis6991/gitsigns.nvim

-- source: https://github.com/lewis6991/gitsigns.nvim?tab=readme-ov-file#-keymaps
on_attach = function(bufnr)
	local gitsigns = require("gitsigns")

	local function map(mode, l, r, opts)
		opts = opts or {}
		opts.buffer = bufnr
		vim.keymap.set(mode, l, r, opts)
	end

	-- Navigation
	map("n", "]c", function()
		if vim.wo.diff then
			vim.cmd.normal({ "]c", bang = true })
		else
			gitsigns.nav_hunk("next")
		end
	end, { desc = "[git] next hunk" })

	map("n", "[c", function()
		if vim.wo.diff then
			vim.cmd.normal({ "[c", bang = true })
		else
			gitsigns.nav_hunk("prev")
		end
	end, { desc = "[git] previous hunk" })

	-- Actions
	map("n", "<leader>hs", gitsigns.stage_hunk, { desc = "[git] stage hunk" })
	map("n", "<leader>hr", gitsigns.reset_hunk, { desc = "[git] reset hunk" })

	map(
		"v",
		"<leader>hs",
		function() gitsigns.stage_hunk({ vim.fn.line("."), vim.fn.line("v") }) end,
		{ desc = "[git] stage hunk (visual selection)" }
	)

	map(
		"v",
		"<leader>hr",
		function() gitsigns.reset_hunk({ vim.fn.line("."), vim.fn.line("v") }) end,
		{ desc = "[git] reset hunk (visual selection)" }
	)

	map("n", "<leader>hS", gitsigns.stage_buffer, { desc = "[git] stage buffer" })
	map("n", "<leader>hR", gitsigns.reset_buffer, { desc = "[git] reset buffer" })

	map("n", "<leader>hp", gitsigns.preview_hunk, { desc = "[git] preview hunk" })
	map("n", "<leader>hi", gitsigns.preview_hunk_inline, { desc = "[git] preview hunk (inline)" })

	map("n", "<leader>hb", function() gitsigns.blame_line({ full = true }) end, { desc = "[git] blame (inline)" })

	map("n", "<leader>hd", gitsigns.diffthis, { desc = "[git] show diff" })
	map("n", "<leader>hD", function() gitsigns.diffthis("~") end, { desc = "[git] show full diff" })

	map("n", "<leader>hQ", function() gitsigns.setqflist("all") end, { desc = "[git] show quick fix list (all)" })
	map("n", "<leader>hq", gitsigns.setqflist, { desc = "[git] show quick fix list" })

	-- Toggles
	-- map("n", "<leader>tb", gitsigns.toggle_current_line_blame, { desc = "[git] toggle current line blame" })
	-- map("n", "<leader>tw", gitsigns.toggle_word_diff, { desc = "[git] toggle word diff" })

	-- Text object
	map({ "o", "x" }, "ih", gitsigns.select_hunk, { desc = "[git] select hunk (text object)" })
end

return {
	"lewis6991/gitsigns.nvim",
	config = function()
		-- https://github.com/norcalli/nvim-colorizer.lua/issues/85
		require("gitsigns").setup({
			on_attach = on_attach,
			signs = {
				delete = { show_count = true },
				topdelete = { show_count = true },
			},
			numhl = false,
			linehl = false,
			word_diff = true,
		})
	end,
}
