return {
	cmd = { "nixd" },
	filetypes = { "nix" },
	root_markers = { "flake.nix", "shell.nix", ".git", "default.nix" },
	settings = {
		nixd = {
			nixpkgs = { expr = "import <nixpkgs> { }" },
			formatting = { command = { "nixfmt" } },
		},
	},
}
