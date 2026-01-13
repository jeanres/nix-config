return {
	"nvim-treesitter/nvim-treesitter",
	lazy = false,
	build = ":TSUpdate",
	opts = {
		ensure_installed = {
			-- Core
			"bash",
			"c",
			"diff",
			"html",
			"lua",
			"luadoc",
			"markdown",
			"markdown_inline",
			"query",
			"vim",
			"vimdoc",
			"ruby",

			-- Programming languages
			"typescript",
			"javascript",
			"python",
			"go",
			"rust",
			"nix",
			"java",
			"c_sharp",
			"typescript",
			"json",
			"yaml",
			"toml",
			"dockerfile",

			-- Web/Config
			"graphql",
			"css",
			"scss",
			"html",
			"jsonc",
		},
		auto_install = true,
		highlight = {
			enable = true,
			additional_vim_regex_highlighting = { "ruby" },
		},
		indent = { enable = true, disable = { "ruby" } },
	},
}
