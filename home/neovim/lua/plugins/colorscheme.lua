return {
	"catppuccin/nvim",
	name = "catppuccin",
	priority = 1000,
	config = function()
		require("catppuccin").setup({
			integration = {
				blink_cmp = true,
			},
		})
		--set background to light

		vim.cmd.colorscheme("catppuccin")
	end,
}
