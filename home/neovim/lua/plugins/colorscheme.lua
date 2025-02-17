return { 
    "rose-pine/neovim", 
    name = "rose-pine",
    config = function()
	require("rose-pine").setup({
	    enable = {
		terminal = true,
		legacy_highlights = true, -- Improve compatibility for previous versions of Neovim
	    },

	    styles = {
		bold = true,
		italic = true,
		transparency = false,
	    },
	})
	vim.cmd("colorscheme rose-pine")
    end
}
