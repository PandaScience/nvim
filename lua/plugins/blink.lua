-- https://github.com/Saghen/blink.cmp

-- change appearance of ghost text
vim.api.nvim_set_hl(0, "BlinkCmpGhostText", { fg = "#B0B0B0", bg = "#404040", italic = true })

return {
	"saghen/blink.cmp",
	dependencies = { "rafamadriz/friendly-snippets" },
	version = "1.*",
	opts_extend = { "sources.default" },
	opts = {
		-- 'default' (recommended) for mappings similar to built-in completions (C-y to accept)
		-- 'super-tab' for mappings similar to vscode (tab to accept)
		-- 'enter' for enter to accept
		-- 'none' for no mappings
		--
		-- All presets have the following mappings:
		-- C-space: Open menu or open docs if already open
		-- C-n/C-p or Up/Down: Select next/previous item
		-- C-e: Hide menu
		-- C-k: Toggle signature help (if signature.enabled = true)
		--
		-- See :h blink-cmp-config-keymap for defining your own keymap
		-- https://github.com/Saghen/blink.cmp/blob/main/lua/blink/cmp/keymap/presets.lua
		keymap = {
			preset = "default",
			["<C-Up>"] = { "scroll_documentation_up", "fallback" },
			["<C-Down>"] = { "scroll_documentation_down", "fallback" },
			["<C-u>"] = { "scroll_signature_up", "fallback" },
			["<C-d>"] = { "scroll_signature_down", "fallback" },
			["<S-Tab>"] = { "select_prev", "fallback" },
			["<Tab>"] = {
				-- accept ghost line suggestion
				function(cmp)
					if cmp.is_ghost_text_visible() then return cmp.show() end
				end,
				-- next menu item
				"select_next",
				-- regular <TAB> keycode
				"fallback",
			},
			["<Right>"] = {
				function(cmp)
					if cmp.is_ghost_text_visible() then return cmp.accept() end
				end,
				"fallback",
			},
			["<CR>"] = {
				function(cmp)
					if cmp.is_menu_visible() then return cmp.accept() end
				end,
				"fallback",
			},
		},

		-- Default list of enabled providers defined so that you can extend it
		-- elsewhere in your config, without redefining it, due to `opts_extend`
		sources = {
			default = { "lsp", "path", "snippets", "buffer" },
			providers = {
				lsp = {
					max_items = 10,
				},
				snippets = {
					max_items = 10,
					-- don't show snippets on trigger characters like `.`
					should_show_items = function(ctx) return ctx.trigger.initial_kind ~= "trigger_character" end,
				},
				cmdline = {
					min_keyword_length = function(ctx)
						-- when typing a command, only show when the keyword is 3 characters or longer
						if ctx.mode == "cmdline" and string.find(ctx.line, " ") == nil then return 3 end
						return 0
					end,
				},
			},
		},

		completion = {
			accept = {
				-- experimental auto-brackets support
				auto_brackets = {
					enabled = true,
				},
			},
			ghost_text = {
				enabled = true,
				show_with_menu = false,
			},
			keyword = {
				range = "full",
			},
			trigger = {
				show_in_snippet = false,
			},
			list = {
				selection = {
					preselect = true,
					auto_insert = false,
				},
			},
			documentation = {
				auto_show = true,
				auto_show_delay_ms = 100,
				window = {
					border = "rounded",
					winhighlight = "Normal:Normal,FloatBorder:FloatBorder,CursorLine:BlinkCmpDocCursorLine,Search:None",
				},
			},
			menu = {
				auto_show = false,
				border = "rounded",
				draw = {
					gap = 2,
					columns = { { "label", "label_description", gap = 1 }, { "kind_icon", "kind" } },
				},
				winhighlight = "Normal:Normal,FloatBorder:FloatBorder,CursorLine:BlinkCmpMenuSelection,Search:None",
			},
		},

		signature = {
			enabled = true,
			trigger = {
				enabled = true,
			},
			window = {
				border = "rounded",
			},
		},

		cmdline = {
			completion = {
				menu = { auto_show = true },
				ghost_text = { enabled = false },
			},
			keymap = {
				-- Shift+Enter or Ctrl+Enter -> accept uncompleted command as-is
				["<CR>"] = { "accept", "fallback" },
				["<S-Tab>"] = { "select_prev", "fallback" },
				["<Tab>"] = { "select_next", "fallback" },
			},
		},
	},
}
