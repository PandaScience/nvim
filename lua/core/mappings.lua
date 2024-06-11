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
-- surround with character (vim-surround)
map(
	"n",
	"<leader>s",
	function() return "ysiW" .. input("Surrounding: ") .. "E" end,
	{ remap = true, expr = true, desc = "Surround with char" }
)
map(
	"v",
	"<leader>s",
	function() return "S" .. input("Surrounding: ") end,
	{ remap = true, expr = true, desc = "Surround selection with char" }
)

-- floaterm
map("n", "<leader>ft", "<cmd>FloatermToggle<CR>")

-- ui toggleables
map("n", "<c-n>", ":NvimTreeFindFileToggle<CR>")
map("n", "<F2>", ":UndotreeToggle<CR>")
map("n", "<F3>", ":Vista!!<CR>")
map("n", "<F4>", ":Trouble diagnostics toggle<CR>")
map("n", "<F5>", ":Magit<CR>")

-- ---------- vim core mappings ------------------------------------------------
-- disable ex-mode
map("n", "Q", "<nop>")

-- comment line
map("n", "<C-/><C-/>", "gcc", { remap = true })
map("v", "<C-/><C-/>", "gc", { remap = true })

-- search and replace word under cursor or visual selection
map("n", "<leader>sr", 'viW"hy:%s/<C-r>h//gc<left><left><left>')
map("v", "<C-r>", '"hy:%s/<C-r>h//gc<left><left><left>')

-- delete next word in insert mode
map("i", "<C-b>", "<C-o>de")

-- close current buffer
map("n", "<leader><C-w>", ":bdelete %<CR>")

-- don't lose selection when shifting sidewards
map("x", "<", "<gv")
map("x", ">", ">gv")

-- visual reselect of just pasted + indent
map("n", "gp", "`[v`]", { desc = "Reselect pasted text" })
map("n", "<leader><", "`[v`]<", { desc = "Indent pasted text to left" })
map("n", "<leader>>", "`[v`]>", { desc = "Indent pasted text to right" })

-- easy clipboard handling, see https://vi.stackexchange.com/a/96
--   * uses PRIMARY;   mnemonic: Star is Select (for copy-on-select)
--   + uses CLIPBOARD; mnemonic: crtl PLUS c (for the common keybind)
-- copy to clipboard
map("v", "<leader>y", '"*y')
map("n", "<leader>Y", '"*yg_')
map("n", "<leader>y", '"*y')
map("n", "<leader>yy", '"*yy')
-- paste from clipboard
map("n", "<leader>p", '"*p')
map("n", "<leader>p", '"*p')
map("n", "<leader>P", '"+P')
map("v", "<leader>P", '"+P')
