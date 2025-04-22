return {
	"vimwiki/vimwiki",
	event = "BufEnter *.md",
	keys = { "<leader>ww", "<leader>wt" },
	init = function()
		vim.g.vimwiki_list = {
			{
				-- Here will be the path for your wiki
				path = "/Users/jeanre.swanepoel/Documents/Notes",
				-- The syntax for the wiki
				ext = "wiki",
			},
		}
	end,
}
