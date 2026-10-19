return {
	{
		"mfussenegger/nvim-dap",
	},
	{
		"mfussenegger/nvim-dap-python",
		dependencies = {
			"mfussenegger/nvim-dap",
		},
		config = function()
			local python = vim.fn.exepath("python3")
			if python == "" then
				python = vim.fn.exepath("python")
			end
			if python == "" then
				vim.notify("Python executable not found", vim.log.levels.ERROR)
				return
			end
			require("dap-python").setup(python)
		end,
	},
	{
		"nvim-neotest/nvim-nio",
	},
	{
		"rcarriga/nvim-dap-ui",
		dependencies = {
			"mfussenegger/nvim-dap",
			"nvim-neotest/nvim-nio",
		},
		config = function()
			local dap = require("dap")
			local dapui = require("dapui")
			dapui.setup()
			dap.listeners.after.event_initialized["dapui"] = function()
				dapui.open()
			end
			dap.listeners.before.event_terminated["dapui"] = function()
				dapui.close()
			end
			dap.listeners.before.event_exited["dapui"] = function()
				dapui.close()
			end
			vim.keymap.set("n", "<leader>db", dap.toggle_breakpoint, { desc = "Toggle breakpoint" })
			vim.keymap.set("n", "<leader>dc", dap.continue, { desc = "Debug continue" })
			vim.keymap.set("n", "<leader>dn", dap.step_over, { desc = "Debug step over" })
			vim.keymap.set("n", "<leader>di", dap.step_into, { desc = "Debug step into" })
			vim.keymap.set("n", "<leader>dO", dap.step_out, { desc = "Debug step out" })
			vim.keymap.set("n", "<leader>du", dapui.toggle, { desc = "Toggle debug UI" })
			vim.keymap.set("n", "<leader>dq", dap.terminate, { desc = "Terminate debug session" })
		end,
	},
}
