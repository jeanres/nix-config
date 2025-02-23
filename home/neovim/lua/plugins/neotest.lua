return {
  "nvim-neotest/neotest",
  dependencies = {
    "nvim-neotest/nvim-nio",
    "nvim-lua/plenary.nvim",
    "antoinemadec/FixCursorHold.nvim",
    "nvim-treesitter/nvim-treesitter",
    "Issafalcon/neotest-dotnet"
  },
  config = function()
    require("neotest").setup({
      adapters = {
        require("neotest-dotnet")({
          dap = {
            args = {justMyCode = false },
            adapter_name = "coreclr"
          },
          dotnet_additional_args = {
            "--verbosity detailed"
          },
          discovery_root = "project" -- Default
        })
      }
    })
  end,
  keys = {
    { "<leader>td", "<cmd>lua require('neotest').run.run({strategy = 'dap'})<CR>" }
  },
}
