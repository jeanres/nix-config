return {
	'nvim-lualine/lualine.nvim',
	event = "VeryLazy",
	config = function()
		require('lualine').setup({
			options = {
      section_separators = { left = '', right = '' },
        component_separators = { left = '', right = '' },

				-- theme = 'dracula',
				-- theme = 'horizon',
				icon_enabled = true
			},
			sections = {
				lualine_x = {
					get_lsp_name,
					--'selectioncount',
					--'filetype'
				},
				lualine_y = {
					'filetype',
					'diagnostics'
				},
			}
		})
	end
}

