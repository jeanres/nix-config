return {
    "catppuccin/nvim",
    name = "catppuccin",
    priority = 1000,
    config = function()
        require("catppuccin").setup({
            integration = {
                blink_cmp = true
            }
        })
        vim.cmd.colorscheme "catppuccin-latte"
    end
}
