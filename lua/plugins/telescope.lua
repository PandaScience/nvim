-- https://github.com/nvim-telescope/telescope.nvim

-- source: https://github.com/nvim-telescope/telescope.nvim/issues/2874
local my_find_files
my_find_files = function(opts, no_ignore)
	opts = opts or {}
	no_ignore = vim.F.if_nil(no_ignore, false)
	opts.attach_mappings = function(_, map)
		map({ "n", "i" }, "<C-h>", function(prompt_bufnr) -- <C-h> to toggle modes
			local prompt = require("telescope.actions.state").get_current_line()
			require("telescope.actions").close(prompt_bufnr)
			no_ignore = not no_ignore
			my_find_files({ default_text = prompt }, no_ignore)
		end)
		return true
	end

	if no_ignore then
		opts.no_ignore = true
		opts.hidden = true
		opts.prompt_title = "Find Files <ALL>"
		require("telescope.builtin").find_files(opts)
	else
		opts.prompt_title = "Find Files"
		require("telescope.builtin").find_files(opts)
	end
end

-- check this config for ideas: https://github.com/ilias777/nvim/blob/main/lua/plugins/telescope.lua
return {
	"nvim-telescope/telescope.nvim",
	dependencies = "nvim-lua/plenary.nvim",
	keys = {
		{ "<C-p>", my_find_files, { desc = "Find files [telescope]" } },
		{ "<leader>ff", "<cmd>Telescope find_files<cr>", { desc = "Find files [telescope]" } },
		{ "<leader>fg", "<cmd>Telescope live_grep<cr>", { desc = "Grep [telescope]" } },
		{ "<leader>fgs", "<cmd>Telescope grep_string<cr>", { desc = "Grep for string under cursor [telescope]" } },
		{ "<leader>fb", "<cmd>Telescope buffers<cr>", { desc = "Find buffer [telescope]" } },
		{ "<leader>fh", "<cmd>Telescope help_tags<cr>", { desc = "Find help tags [telescope]" } },
		{ "<C-l>", "<cmd>Telescope lsp_document_symbols<cr>", { desc = "Find lsp symbols [telescope]" } },
	},
	config = function()
		local actions = require("telescope.actions")
		local action_layout = require("telescope.actions.layout")

		require("telescope").setup({
			defaults = {
				mappings = {
					i = {
						["<esc>"] = actions.close,
						["<C-p>"] = action_layout.toggle_preview,
						["<C-Up>"] = actions.preview_scrolling_up,
						["<C-Down>"] = actions.preview_scrolling_down,
					},
				},
			},
			pickers = {
				find_files = {
					layout_config = {
						prompt_position = "top",
						preview_width = 0.7,
					},
					sorting_strategy = "ascending",
				},
				help_tags = {
					theme = "ivy",
				},
				symbols = {
					theme = "dropdown",
				},
				registers = {
					theme = "ivy",
				},
				grep_string = {
					initial_mode = "normal",
					theme = "ivy",
				},
				live_grep = {
					theme = "ivy",
				},
			},
		})
	end,
}
