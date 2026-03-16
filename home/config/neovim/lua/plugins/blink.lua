return {
	"saghen/blink.cmp",
	version = "*", -- use a tagged release for versionless API
	dependencies = {
		"rafamadriz/friendly-snippets", -- optional: premade snippets
	},

	---@module 'blink.cmp'
	---@type blink.cmp.Config
	opts = {
		keymap = {
			preset = "default",
		},

		appearance = {
			nerd_font_variant = "mono",
		},

		completion = {
			-- Show documentation window automatically
			documentation = {
				auto_show = true,
				auto_show_delay_ms = 200,
			},
			-- Ghost text (inline preview)
			ghost_text = {
				enabled = true,
			},
			-- Highlight matched text in menu
			menu = {
				draw = {
					treesitter = { "lsp" },
					columns = {
						{ "label", "label_description", gap = 1 },
						{ "kind_icon", "kind" },
					},
				},
			},
		},

		sources = {
			-- Default source groups: lsp, path, snippets, buffer
			default = { "lsp", "path", "snippets", "buffer" },
			-- Optionally add cmdline completion:
			-- cmdline = {},
		},

		fuzzy = { implementation = "prefer_rust_with_warning" },

		-- Enable LSP capabilities for blink (auto-configured)
		-- Uncomment if you need manual control:
		-- signature = { enabled = true },
	},

	opts_extend = { "sources.default" },
}
