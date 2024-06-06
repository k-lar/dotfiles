return {
    {
        "ribru17/bamboo.nvim",
        lazy = false,
        priority = 1000,
        config = function()
            require("bamboo").setup({
                style = "multiplex",
                code_style = {
                    comments = "none",
                    conditionals = "none",
                    keywords = "none",
                    functions = "bold",
                    namespaces = "none",
                    parameters = "none",
                    strings = "none",
                    variables = "none",
                },
                highlights = {
                    ["@comment"] = { fg = "$grey" },
                },
            })
            require("bamboo").load()
        end,
    },
    {
        "nvim-lualine/lualine.nvim",
        opts = {
            options = {
                theme = "bamboo",
                section_separators = "",
                component_separators = "",
            },
        },
    },
}
