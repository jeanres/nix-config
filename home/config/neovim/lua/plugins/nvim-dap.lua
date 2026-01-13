return {
	"mfussenegger/nvim-dap",
	config = function()
		local dap = require("dap")

		dap.adapters.netcoredbg = {
			type = "executable",
			command = "netcoredbg",
			args = { "--interpreter=vscode" },
		}
		local function get_launch_settings()
			local file_path = vim.fn.getcwd() .. '/Properties/launchSettings.json'
			if vim.fn.filereadable(file_path) == 0 then
				return nil
			end

			local content = vim.fn.readfile(file_path)
			local launch_settings = vim.fn.json_decode(table.concat(content, '\n'))
			return launch_settings
		end

		local function create_dap_config_from_launch_settings()
			local launch_settings = get_launch_settings()
			if not launch_settings then
				return {}
			end

			local configs = {}
			for profile_name, profile in pairs(launch_settings.profiles or {}) do
				if profile.commandName == "Project" then
					table.insert(configs, {
						type = "netcoredbg",
						name = "Launch: " .. profile_name,
						request = "launch",
						program = function()
							return vim.fn.input('Path to dll: ', vim.fn.getcwd() .. '/bin/Debug/', 'file')
						end,
						env = profile.environmentVariables or {},
						args = profile.commandLineArgs and vim.split(profile.commandLineArgs, ' ') or {},
						cwd = vim.fn.getcwd(),
						stopAtEntry = false,
					})
				end
			end

			return configs
		end

		dap.configurations.cs = create_dap_config_from_launch_settings()
	end,
	keys = {
		{ "<leader>dt", "<cmd>lua require'dap'.toggle_breakpoint()<cr>",      desc = "Toggle Breakpoint" },
		{ "<leader>db", "<cmd>lua require'dap'.step_back()<cr>",              desc = "Step Back" },
		{ "<leader>dc", "<cmd>lua require'dap'.continue()<cr>",               desc = "Continue" },
		{ "<leader>dC", "<cmd>lua require'dap'.run_to_cursor()<cr>",          desc = "Run To Cursor" },
		{ "<leader>dd", "<cmd>lua require'dap'.disconnect()<cr>",             desc = "Disconnect" },
		{ "<leader>dg", "<cmd>lua require'dap'.session()<cr>",                desc = "Get Session" },
		{ "<leader>di", "<cmd>lua require'dap'.step_into()<cr>",              desc = "Step Into" },
		{ "<leader>do", "<cmd>lua require'dap'.step_over()<cr>",              desc = "Step Over" },
		{ "<leader>du", "<cmd>lua require'dap'.step_out()<cr>",               desc = "Step Out" },
		{ "<leader>dp", "<cmd>lua require'dap'.pause()<cr>",                  desc = "Pause" },
		{ "<leader>dr", "<cmd>lua require'dap'.repl.toggle()<cr>",            desc = "Toggle Repl" },
		{ "<leader>ds", "<cmd>lua require'dap'.continue()<cr>",               desc = "Start" },
		{ "<leader>dq", "<cmd>lua require'dap'.close()<cr>",                  desc = "Quit" },
		{ "<leader>dU", "<cmd>lua require'dapui'.toggle({reset = true})<cr>", desc = "Toggle UI" },
	},
}
