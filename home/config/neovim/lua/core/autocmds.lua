vim.api.nvim_create_autocmd("LspAttach", {
	callback = function(args)
		local buf = args.buf

		local keymap = function(mode, lhs, rhs)
			vim.keymap.set(mode, lhs, rhs, { buffer = buf })
		end

		keymap("n", "gd", vim.lsp.buf.definition)
		keymap("n", "gr", vim.lsp.buf.references)
		keymap("n", "gi", vim.lsp.buf.implementation)
		keymap("n", "K", vim.lsp.buf.hover)

		keymap("n", "<leader>r", vim.lsp.buf.rename)
		keymap({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action)
	end,
})
