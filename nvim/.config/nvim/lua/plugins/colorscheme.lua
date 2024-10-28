return {
    -- If you want to add a custom colorscheme
    -- make sure you set vim.g.custom_colorscheme_loaded to true
    { "k-lar/dark-pale-gruvbox-lualine.nvim", lazy = false },
    {
        "nvim-lualine/lualine.nvim",
        event = "UIEnter",
        opts = {
            options = {
                theme = "gruvbox-dark-pale",
                section_separators = "",
                component_separators = "",
            },
        },
    },
}
