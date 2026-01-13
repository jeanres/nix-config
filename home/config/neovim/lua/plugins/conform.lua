return {
	"stevearc/conform.nvim",
	lazy = false,
	opts = {
		notify_on_error = false,
		format_on_save = function(bufnr)
			return {
				timeout_ms = 500,
				lsp_fallback = true,
			}
		end,
		formatters_by_ft = {
			lua = { "stylua" },
			python = { "black", "isort" },
			javascript = { "prettier" },
			typescript = { "prettier" },
			typescriptreact = { "prettier" },
			javascriptreact = { "prettier" },
			go = { "gofmt" },
			rust = { "rustfmt" },
			nix = { "nixfmt" },
			cs = { "csharpier" },
			java = { "google-java-format" },
			sh = { "shfmt" },
			markdown = { "prettier" },
		},
	},
}
