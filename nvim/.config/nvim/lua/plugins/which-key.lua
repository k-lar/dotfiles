return {
    {
        "folke/which-key.nvim",
        opts = {
            icons = {
                -- set icon mappings to true if you have a Nerd Font
                mappings = false,
                -- If you are using a Nerd Font: set icons.keys to an empty table which will use the
                -- default whick-key.nvim defined Nerd Font icons, otherwise define a string table
                keys = vim.g.have_nerd_font and {} or {
                    Up = "<Up> ",
                    Down = "<Down> ",
                    Left = "<Left> ",
                    Right = "<Right> ",
                    C = "<C-…> ",
                    M = "<M-…> ",
                    D = "<D-…> ",
                    S = "<S-…> ",
                    CR = "<CR> ",
                    Esc = "<Esc> ",
                    ScrollWheelDown = "<ScrollWheelDown> ",
                    ScrollWheelUp = "<ScrollWheelUp> ",
                    NL = "<NL> ",
                    BS = "<BS> ",
                    Space = "<Space> ",
                    Tab = "<Tab> ",
                    F1 = "<F1>",
                    F2 = "<F2>",
                    F3 = "<F3>",
                    F4 = "<F4>",
                    F5 = "<F5>",
                    F6 = "<F6>",
                    F7 = "<F7>",
                    F8 = "<F8>",
                    F9 = "<F9>",
                    F10 = "<F10>",
                    F11 = "<F11>",
                    F12 = "<F12>",
                },
            },
            triggers = {
                { "<auto>", mode = "nixsotc" },
                -- See mini.surround bindings
                { "s", mode = { "n", "v" } },
            },
            spec = {
                { "<leader>F", group = "[F]ormatting" },
                { "<leader>S", group = "[S]pell" },
                { "<leader>c", group = "[C]ode" },
                { "<leader>d", group = "[D]ocument" },
                { "<leader>g", group = "[G]it" },
                { "<leader>r", group = "[R]ename" },
                { "<leader>s", group = "[S]earch" },
                { "<leader>t", group = "[T]oggle" },
                { "<leader>w", group = "[W]orkspace" },
            },
        },
        event = "VimEnter",
    },
}
