return {
    {
        "lewis6991/gitsigns.nvim",
        opts = {
            signcolumn = false,
            signs = {
                add = { text = "+" },
                change = { text = "~" },
                delete = { text = "_" },
                topdelete = { text = "‾" },
                changedelete = { text = "~" },
            },
        },
        -- stylua: ignore
        keys = {
            { "<leader>G", function() require("gitsigns").toggle_signs() end, desc = "Toggle gitgutter signs" },
            { "<leader>gp", function() require("gitsigns").prev_hunk() end, desc = "Previous hunk" },
            { "<leader>gn", function() require("gitsigns").next_hunk() end, desc = "Next hunk" },
            { "<leader>gs", function() require("gitsigns").stage_hunk() end, desc = "Stage hunk" },
            { "<leader>gr", function() require("gitsigns").reset_hunk() end, desc = "Reset hunk" },
            { "<leader>gu", function() require("gitsigns").undo_stage_hunk() end, desc = "Undo staged hunk" },
            { "<leader>gh", function() require("gitsigns").preview_hunk() end, desc = "Preview hunk" },
        },
    },
}
