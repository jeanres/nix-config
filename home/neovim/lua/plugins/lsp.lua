return {
	"neovim/nvim-lspconfig",
	dependencies = {
		{
			"seblyng/roslyn.nvim",
			ft = "cs",
			opts = {
				filewatching = "roslyn",
			},
		},
		{ "saghen/blink.cmp" },
	},
	config = function()
		local lspconfig = require("lspconfig")
		local capabilities = require("blink.cmp").get_lsp_capabilities()

		-- Common on_attach function
		local on_attach = function(client, bufnr)
			local opts = { buffer = bufnr, noremap = true, silent = true }

			vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, opts)
			vim.keymap.set("n", "gD", vim.lsp.buf.declaration, opts)
			vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
			vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
			vim.keymap.set("n", "gi", vim.lsp.buf.implementation, opts)
			vim.keymap.set("n", "<C-k>", vim.lsp.buf.signature_help, opts)
			vim.keymap.set("n", "<space>wa", vim.lsp.buf.add_workspace_folder, opts)
			vim.keymap.set("n", "<space>wr", vim.lsp.buf.remove_workspace_folder, opts)
			vim.keymap.set("n", "<space>wl", function()
				print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
			end, opts)
			vim.keymap.set("n", "<space>D", vim.lsp.buf.type_definition, opts)
			vim.keymap.set("n", "<space>rn", vim.lsp.buf.rename, opts)
			vim.keymap.set("n", "gr", vim.lsp.buf.references, opts)
			vim.keymap.set("n", "<space>e", vim.diagnostic.open_float, opts)
			vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, opts)
			vim.keymap.set("n", "]d", vim.diagnostic.goto_next, opts)
			vim.keymap.set("n", "<space>q", vim.diagnostic.setloclist, opts)
		end

		-- LSP Servers configuration
		local servers = {
			ruby_lsp = {},
			gopls = {},
			dartls = {},
			ts_ls = {}, -- `ts_ls` corrected to `tsserver`
			lua_ls = {},
			nixd = {},
			terraformls = {},
		}

		for server, opts in pairs(servers) do
			lspconfig[server].setup({
				on_attach = on_attach,
				capabilities = capabilities,
				settings = opts.settings or {},
			})
		end
		vim.lsp.enable("roslyn_ls")
	end,
}
