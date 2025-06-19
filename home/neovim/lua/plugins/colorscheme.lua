return {
	"catppuccin/nvim",
	name = "catppuccin",
	priority = 1000,
	config = function()
		require("catppuccin").setup({
			transparent_background = true, -- disables setting the background color.
			integration = {
				blink_cmp = true,
			},
		})
		--set background to light

		vim.cmd.colorscheme("catppuccin")
	end,
}
