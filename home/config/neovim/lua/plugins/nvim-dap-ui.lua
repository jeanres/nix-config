return {
	"rcarriga/nvim-dap-ui",
	dependencies = { "mfussenegger/nvim-dap", "nvim-neotest/nvim-nio" },
	config = function()
		require("dapui").setup({
			layouts = {
				-- Only show variables and call stack on the left
				{
					elements = {
						"scopes",
						"stacks",
					},
					size = 40,
					position = "left",
				},
				-- Only show REPL at bottom
				{
					elements = {
						"repl",
					},
					size = 10,
					position = "bottom",
				},
			},
			controls = {
				enabled = false, -- Disable the floating control buttons
			},
			render = {
				max_type_length = nil, -- Can be set to an integer
				max_value_lines = 100,
				indent = 1,
			},
		})

		local dap, dapui = require("dap"), require("dapui")
		dap.listeners.before.attach.dapui_config = function()
			dapui.open()
		end
		dap.listeners.before.launch.dapui_config = function()
			dapui.open()
		end
		dap.listeners.before.event_terminated.dapui_config = function()
			dapui.close()
		end
		dap.listeners.before.event_exited.dapui_config = function()
			dapui.close()
		end
	end,
}
