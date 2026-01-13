vim.lsp.config("lua_ls", {
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
})

vim.lsp.config("nixd", {
	cmd = { "nixd" },
	filetypes = { "nix" },
	root_markers = { "flake.nix", "shell.nix", ".git", "default.nix" },
	settings = {
		nixd = {
			nixpkgs = { expr = "import <nixpkgs> { }" },
			formatting = { command = { "nixfmt" } },
		},
	},
})

-- Configure jdtls with Lombok support
local lombok_jar = os.getenv("LOMBOK_JAR") or ""
local jdtls_cmd = { "jdtls" }

-- Add Lombok as a Java agent if the JAR path is available
if lombok_jar ~= "" then
	table.insert(jdtls_cmd, string.format("--jvm-arg=-javaagent:%s", lombok_jar))
end

vim.lsp.config("jdtls", {
	cmd = jdtls_cmd,
	filetypes = { "java" },
	root_markers = {
		"mvnw",
		"gradlew",
		"settings.gradle",
		"settings.gradle.kts",
		".git",
		"build.xml",
		"pom.xml",
		"build.gradle",
		"build.gradle.kts",
	},
	settings = {
		java = {
			jdt = {
				ls = {
					lombokSupport = { enabled = true },
				},
			},
		},
	},
	init_options = {
		bundles = {},
		extendedClientCapabilities = {
			classFileContentsSupport = true,
		},
	},
})

vim.lsp.config("ts_ls", {
	cmd = { "typescript-language-server", "--stdio" },
	filetypes = { "typescript", "typescriptreact", "javascript", "javascriptreact" },
	root_markers = { "package.json", "tsconfig.json", "jsconfig.json", ".git" },
})

vim.lsp.config("rust_analyzer", {
	cmd = { "rust-analyzer" },
	filetypes = { "rust" },
	root_markers = { "Cargo.toml", ".git" },
})

vim.lsp.config("pyright", {
	cmd = { "pyright" },
	filetypes = { "python" },
	root_markers = { "pyproject.toml", "setup.py", "requirements.txt", ".git" },
})

vim.lsp.config("gopls", {
	cmd = { "gopls" },
	filetypes = { "go", "gomod", "gosum" },
	root_markers = { "go.mod", ".git" },
})

vim.lsp.config("marksman", {
	cmd = { "marksman" },
	filetypes = { "markdown", "markdown.mdx" },
	root_markers = { ".git", ".marksman.toml" },
})

vim.lsp.config("bashls", {
	cmd = { "bash-language-server", "start" },
	filetypes = { "sh", "bash", "zsh" },
	root_markers = { ".git" },
})

vim.lsp.config("ruby_ls", {
	cmd = { "ruby-lsp" },
	filetypes = { "ruby" },
	root_markers = { "Gemfile", ".git" },
})

vim.lsp.enable({
	"lua_ls",
	"nixd",
	"jdtls",
	"ruby_ls",
	"ts_ls",
	"rust_analyzer",
	"pyright",
	"gopls",
	"marksman",
	"bashls",
})
