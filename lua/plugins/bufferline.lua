require("bufferline").setup{
	options = {
		numbers = 'none',
		right_mouse_command = nil,
		middle_mouse_command = 'bdelete! %d',
		diagnostics = 'nvim_lsp',
		separator_style = 'slant',

		diagnostics_indicator = function(count, level, diagnostics_dict, context)
			local icon = level:match('error') and ' ' or ' '
			return " " .. icon .. count
		end,

		offsets = {
			{ filetype = 'NvimTree', text = 'File Explorer', text_align = 'left' },
			{ filetype = 'Vista', text = 'Tagbar', text_align = 'right' },
		},

		custom_areas = {
			right = function()
				local result = {}
				local seve = vim.diagnostic.severity
				local error = #vim.diagnostic.get(0, {severity = seve.ERROR})
				local warning = #vim.diagnostic.get(0, {severity = seve.WARN})
				local info = #vim.diagnostic.get(0, {severity = seve.INFO})
				local hint = #vim.diagnostic.get(0, {severity = seve.HINT})

				if error ~= 0 then
				table.insert(result, {text = '  ' .. error, fg = '#EC5241'})
				end

				if warning ~= 0 then
				table.insert(result, {text = '  ' .. warning, fg = '#EFB839'})
				end

				if hint ~= 0 then
				table.insert(result, {text = '  ' .. hint, fg = '#A3BA5E'})
				end

				if info ~= 0 then
				table.insert(result, {text = '  ' .. info, fg = '#7EA9A7'})
				end

				table.insert(result, {text = os.date('%H:%M'), bg = '#000000', fg = '#CCCCCC'})
				return result
			end
		},
	},

	highlights = {
		-- background = {
		-- 	fg = '#FF0000',
		-- 	bg = '#ABCD00'
		-- },
		-- fill = {
		-- 	fg = '#FF66FF',
		-- 	bg = '#A2F3F5'
		-- },
		-- buffer_selected = {
		-- 	fg = '#A166FF',
		-- 	bg = '#F2FF55'
		-- },
		-- separator = {
		-- 	fg = '#1166FF',
		-- 	bg = '#F2AF55'
		-- },
		-- buffer = {
		-- 	fg = '#6666FF',
		-- 	bg = '#12AF55'
		-- },
		fill = {
			bg = '#555555',
		},
		separator = {
			fg = '#555555',
		},
		separator_selected = {
			fg = '#555555',
		},
		buffer_selected = {
			fg = '#9e884a',
		},
	}
}

local map = vim.keymap.set

map('n', 'bp', ':BufferLinePick <CR>')
map('n', 'bd', ':BufferLinePickClose <CR>')

map('n', 'bm<Right>', ':BufferLineMoveNext<CR>')
map('n', 'bm<Left>',  ':BufferLineMovePrev<CR>')

map('n', '<tab>',   ':BufferLineCycleNext<CR>')
map('n', '<s-tab>', ':BufferLineCyclePrev<CR>')

map('n', '<leader>1', '<Cmd>BufferLineGoToBuffer 1<CR>')
map('n', '<leader>2', '<Cmd>BufferLineGoToBuffer 2<CR>')
map('n', '<leader>3', '<Cmd>BufferLineGoToBuffer 3<CR>')
map('n', '<leader>4', '<Cmd>BufferLineGoToBuffer 4<CR>')
map('n', '<leader>5', '<Cmd>BufferLineGoToBuffer 5<CR>')
map('n', '<leader>6', '<Cmd>BufferLineGoToBuffer 6<CR>')
map('n', '<leader>7', '<Cmd>BufferLineGoToBuffer 7<CR>')
map('n', '<leader>8', '<Cmd>BufferLineGoToBuffer 8<CR>')
map('n', '<leader>9', '<Cmd>BufferLineGoToBuffer 9<CR>')
