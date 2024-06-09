-- https://github.com/akinsho/bufferline.nvim

local opts = {
	options = {
		numbers = "none",
		right_mouse_command = nil,
		middle_mouse_command = "bdelete! %d",
		diagnostics = "nvim_lsp",
		separator_style = "slant",

		diagnostics_indicator = function(count, level, diagnostics_dict, context)
			local icon = level:match("error") and " " or " "
			return " " .. icon .. count
		end,

		offsets = {
			{ filetype = "NvimTree", text = "File Explorer", text_align = "left" },
			{ filetype = "Vista", text = "Tagbar", text_align = "right" },
		},

		custom_areas = {
			right = function()
				local result = {}
				local seve = vim.diagnostic.severity
				local error = #vim.diagnostic.get(0, { severity = seve.ERROR })
				local warning = #vim.diagnostic.get(0, { severity = seve.WARN })
				local info = #vim.diagnostic.get(0, { severity = seve.INFO })
				local hint = #vim.diagnostic.get(0, { severity = seve.HINT })

				if error ~= 0 then table.insert(result, { text = "  " .. error, fg = "#EC5241" }) end

				if warning ~= 0 then table.insert(result, { text = "  " .. warning, fg = "#EFB839" }) end

				if hint ~= 0 then table.insert(result, { text = "  " .. hint, fg = "#A3BA5E" }) end

				if info ~= 0 then table.insert(result, { text = "  " .. info, fg = "#7EA9A7" }) end

				table.insert(result, { text = os.date("%H:%M"), bg = "#000000", fg = "#CCCCCC" })
				return result
			end,
		},
	},

	highlights = {
		fill = {
			bg = "#555555",
		},
		separator = {
			fg = "#555555",
		},
		separator_selected = {
			fg = "#555555",
		},
		buffer_selected = {
			fg = "#9e884a",
		},
	},
}

return {
	"akinsho/bufferline.nvim",
	lazy = false,
	version = "*",
	dependencies = "nvim-tree/nvim-web-devicons",
	opts = opts,
	keys = {
		{ "bp", ":BufferLinePick <CR>" },
		{ "bd", ":BufferLinePickClose <CR>" },

		{ "bm<Right>", ":BufferLineMoveNext<CR>" },
		{ "bm<Left>", ":BufferLineMovePrev<CR>" },

		{ "<tab>", ":BufferLineCycleNext<CR>" },
		{ "<s-tab>", ":BufferLineCyclePrev<CR>" },

		{ "<leader>1", "<Cmd>BufferLineGoToBuffer 1<CR>" },
		{ "<leader>2", "<Cmd>BufferLineGoToBuffer 2<CR>" },
		{ "<leader>3", "<Cmd>BufferLineGoToBuffer 3<CR>" },
		{ "<leader>4", "<Cmd>BufferLineGoToBuffer 4<CR>" },
		{ "<leader>5", "<Cmd>BufferLineGoToBuffer 5<CR>" },
		{ "<leader>6", "<Cmd>BufferLineGoToBuffer 6<CR>" },
		{ "<leader>7", "<Cmd>BufferLineGoToBuffer 7<CR>" },
		{ "<leader>8", "<Cmd>BufferLineGoToBuffer 8<CR>" },
		{ "<leader>9", "<Cmd>BufferLineGoToBuffer 9<CR>" },
	},
}
