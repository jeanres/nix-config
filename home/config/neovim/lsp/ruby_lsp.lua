return {
	cmd = { "bundle", "exec", "ruby-lsp" },
	filetypes = { "ruby" },
	root_markers = { "Gemfile", ".git" },
	settings = {
		rubyLsp = {
			enabledFeatures = {
				codeActions = true,
				codeLens = true,
				completion = true,
				definition = true,
				diagnostics = true,
				documentHighlights = true,
				documentLink = true,
				documentSymbols = true,
				foldingRanges = true,
				formatting = true,
				hover = true,
				inlayHint = true,
				selectionRanges = true,
				semanticHighlighting = true,
				signatureHelp = true,
				typeHierarchy = true,
				workspaceSymbol = true,
			},
		},
	},
}
