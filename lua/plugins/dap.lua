-- https://github.com/mfussenegger/nvim-dap
-- https://github.com/rcarriga/nvim-dap-ui
-- https://github.com/theHamsta/nvim-dap-virtual-text
-- https://github.com/leoluz/nvim-dap-go

-- config sources:
-- https://medium.com/@suyash10581108/go-lang-debugging-simplified-in-neovim-with-delve-and-dap-760bb950305d
-- https://harrisoncramer.me/debugging-in-neovim/
-- https://miguelcrespo.co/posts/how-to-debug-like-a-pro-using-neovim/

-- TODO: https://github.com/theHamsta/nvim-dap-virtual-text
-- TODO: https://github.com/LiadOz/nvim-dap-repl-highlights

-- TODO: https://github.com/anuvyklack/hydra.nvim
-- https://www.reddit.com/r/neovim/comments/1e0sivx/any_suggestions_on_better_mapping_for_nvimdap/?rdt=46278

return {
	{
		"mfussenegger/nvim-dap",
		ft = "go",
		dependencies = { "rcarriga/nvim-notify" },
		config = function()
			local dap, dapui = require("dap"), require("dapui")
			local notify = require("notify")
			dap.listeners.before.attach.dapui_config = function() dapui.open() end
			dap.listeners.before.launch.dapui_config = function() dapui.open() end
			dap.listeners.before.event_terminated.dapui_config = function() dapui.close() end
			dap.listeners.before.event_exited.dapui_config = function() dapui.close() end

			vim.fn.sign_define("DapBreakpoint", { text = "🔴" }) --🐞
			vim.fn.sign_define("DapBreakpointCondition", { text = "🔀" })
			vim.fn.sign_define("DapBreakpointRejected", { text = "❌" })
			vim.fn.sign_define("DapLogPoint", { text = "" })
			vim.fn.sign_define(
				"DapStopped",
				{ text = "", texthl = "@comment.todo", linehl = "", numhl = "@comment.todo" }
			)

			vim.keymap.set("n", "<localleader>w", dapui.open, { desc = "[dap] Open UI" })
			vim.keymap.set("n", "<localleader>W", dapui.close, { desc = "[dap] Close UI" })
			vim.keymap.set("n", "<localleader>s", dap.continue, { desc = "[dap] Start" }) -- intentionally same as <localleader>c
			vim.keymap.set("n", "<localleader>S", dap.run_last, { desc = "[dap] Start last" })
			vim.keymap.set("n", "<localleader>r", dap.run_last, { desc = "[dap] Restart" })
			vim.keymap.set("n", "<localleader>c", dap.continue, { desc = "[dap] Continue" })
			vim.keymap.set("n", "<localleader>n", dap.step_over, { desc = "[dap] Step over" })
			vim.keymap.set("n", "<localleader>i", dap.step_into, { desc = "[dap] Step into" })
			vim.keymap.set("n", "<localleader>o", dap.step_out, { desc = "[dap] Step out" })
			vim.keymap.set("n", "<localleader>C", dap.clear_breakpoints, { desc = "[dap] Clear breakpoints" })
			vim.keymap.set("n", "<localleader>b", dap.toggle_breakpoint, { desc = "[dap] Toggle Breakpoint" })

			vim.keymap.set("n", "<localleader>L", function()
				local log_point_msg = vim.fn.input("Log point message: ")
				dap.set_breakpoint(nil, nil, log_point_msg)
			end)

			vim.keymap.set("n", "<localleader>B", function()
				local condition = vim.fn.input("Condition: ")
				local hit_condition = vim.fn.input("Hit condition: ")
				dap.set_breakpoint(condition, hit_condition, nil)
			end)

			vim.keymap.set("n", "<localleader>e", function()
				dap.terminate()
				notify("Debugger session ended", "warn")
			end, { desc = "[dap] End session" })

			-- for convenience...
			-- vim.keymap.set("n", "<F5>", dap.continue)
			-- vim.keymap.set("n", "<F10>", dap.step_over)
			-- vim.keymap.set("n", "<F11>", dap.step_into)
			-- vim.keymap.set("n", "<F12>", dap.step_out)
		end,
	},
	{ "leoluz/nvim-dap-go", opts = {} },
	{ "rcarriga/nvim-dap-ui", dependencies = { "mfussenegger/nvim-dap", "nvim-neotest/nvim-nio" }, opts = {} },
}
