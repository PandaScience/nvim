-- Modes
--   normal_mode = "n",
--   insert_mode = "i",
--   visual_mode = "v",
--   visual_block_mode = "x",
--   term_mode = "t",
--   command_mode = "c",
local map = vim.keymap.set
local input = vim.fn.input

-- ---------- plugin related mappings ------------------------------------------
-- vim-move arrow keys bindings
map('n', '<A-Up>',    '<Plug>MoveLineUp')
map('n', '<A-Down>',  '<Plug>MoveLineDown')
map('n', '<A-Left>',  '<Plug>MoveCharLeft')
map('n', '<A-Right>', '<Plug>MoveCharRight')
map('v', '<A-Up>',    '<Plug>MoveBlockUp')
map('v', '<A-Down>',  '<Plug>MoveBlockDown')
map('v', '<A-Left>',  '<Plug>MoveBlockLeft')
map('v', '<A-Right>', '<Plug>MoveBlockRight')

-- surround with character (vim-surround)
map('n', '<leader>s', function() return 'ysiW' .. input('Surrounding: ') .. 'E' end, {remap=true, expr=true, desc='Surround with char'})

-- comment line; it's actually <C-/><C-/> but nvim receives '^_^_' (any comment plugin)
map('n', '<C-_><C-_>', 'gcc', {remap=true})
map('v', '<C-_><C-_>', 'gc', {remap=true})

-- fzf mappings
map('n', '<C-p>',     '<cmd>FzfLua files<CR>')
map('n', '<leader>f', '<cmd>FzfLua files<CR>')
map('n', '<leader>z', '<cmd>FzfLua builtin<CR>')

-- floaterm
map('n', '<leader>ft', '<cmd>FloatermToggle<CR>')

-- ui toggleables
map('n', '<F2>', ':UndotreeToggle<CR>')
map('n', '<c-n>',':NvimTreeFindFileToggle<CR>')
-- map('n', '<F5>', ':Neogit<CR>')
map('n', '<F3>', ':Vista!!<CR>')
map('n', '<F4>', ':TroubleToggle<CR>')
map('n', '<F5>', ':Magit<CR>')

-- ---------- vim core mappings ------------------------------------------------
-- disable ex-mode
map('n', 'Q', '<nop>')

-- search and replace word under cursor or visual selection
map('n', '<leader>sr', 'viW"hy:%s/<C-r>h//gc<left><left><left>')
map('v', '<C-r>', '"hy:%s/<C-r>h//gc<left><left><left>')

-- delete next word in insert mode
map('i', '<C-b>', '<C-o>de')

-- shortcut for switching between buffers
-- map('n', '<tab>', ':bn <cr>')
-- map('n', '<s-tab>', ':bp <cr>')

-- close current buffer
map('n', '<leader><C-w>', ':bdelete %<CR>')

-- don't lose selection when shifting sidewards
map('x', '<', '<gv')
map('x', '>', '>gv')

-- visual reselect of just pasted
map('n', 'gp', '`[v`]')

-- easy clipboard handling, see https://vi.stackexchange.com/a/96
--   * uses PRIMARY;   mnemonic: Star is Select (for copy-on-select)
--   + uses CLIPBOARD; mnemonic: crtl PLUS c (for the common keybind)
-- copy to clipboard
map('v', '<leader>y',  '"*y'  )
map('n', '<leader>Y',  '"*yg_')
map('n', '<leader>y',  '"*y'  )
map('n', '<leader>yy', '"*yy' )
-- paste from clipboard
map('n', '<leader>p', '"*p')
map('n', '<leader>p', '"*p')
map('n', '<leader>P', '"+P')
map('v', '<leader>P', '"+P')
