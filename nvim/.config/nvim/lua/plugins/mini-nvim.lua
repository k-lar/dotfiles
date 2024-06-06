return {
    { "echasnovski/mini.comment", opts = {} },
    { "echasnovski/mini.surround", opts = {} },
    { "echasnovski/mini.indentscope", opts = { symbol = "│" } },
    {
        "echasnovski/mini.move",
        config = function()
            require("mini.move").setup({
                mappings = {
                    -- Move visual selection in Visual mode. Defaults are Alt (Meta) + hjkl.
                    left = "<C-Left>",
                    right = "<C-Right>",
                    down = "<C-Down>",
                    up = "<C-Up>",

                    -- Move current line in Normal mode
                    line_left = "<C-Left>",
                    line_right = "<C-Right>",
                    line_down = "<C-Down>",
                    line_up = "<C-Up>",
                },
            })
        end,
    },
}
