return {
    { "danymat/neogen", config = true, cmd = "Neogen" },
    {
        "folke/flash.nvim",
        event = "VeryLazy",
        ---@type Flash.Config
        opts = {
            modes = {
                search = {
                    enabled = false,
                },
            },
        },
        -- stylua: ignore
        keys = {
            { "<Enter>", mode = { "n", "x", "o" }, function() require("flash").jump() end, desc = "Flash" },
            { "<S-Enter>", mode = { "n", "x", "o" }, function() require("flash").treesitter() end, desc = "Flash Treesitter" },
            { "r", mode = "o", function() require("flash").remote() end, desc = "Remote Flash" },
            { "R", mode = { "o", "x" }, function() require("flash").treesitter_search() end, desc = "Treesitter Search" },
            { "<c-s>", mode = { "c" }, function() require("flash").toggle() end, desc = "Toggle Flash Search" },
        },
    },
    {
        "folke/todo-comments.nvim",
        event = "VimEnter",
        opts = {
            signs = false,
            keywords = {
                TODO = { color = "hint" },
                NOTE = { color = "info" },
            },
        },
    },
    {
        "brenoprata10/nvim-highlight-colors",
        event = "VeryLazy",
        opts = {
            render = "virtual",
            virtual_symbol_position = "eol",
            virtual_symbol = "■",
            virtual_symbol_suffix = " ",
            virtual_symbol_prefix = "",
            enable_tailwind = true,
        },
    },
}
