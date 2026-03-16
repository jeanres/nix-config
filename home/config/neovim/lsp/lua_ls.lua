return {
	cmd = { "lua-language-server" },
	filetypes = { "lua" },
	root_markers = { ".git", ".luarc.json", ".luarc.jsonc", ".stylua.toml", "selene.toml" },
	single_file_support = true,
	settings = {
		Lua = {
			runtime = { version = "LuaJIT" },
			workspace = {
				checkThirdParty = false,
				library = vim.api.nvim_list_runtime_paths(),
			},
			completion = { callSnippet = "Replace" },
			hint = { enable = true },
		},
	},
}
