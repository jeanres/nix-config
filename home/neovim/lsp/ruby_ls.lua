return {
	cmd = { "ruby-lsp" },
	filetypes = { "ruby" },
	root_dir = function(fname)
		return require("lspconfig.util").root_pattern("Gemfile", ".git")(fname)
	end,
}