return {
    {
        "github/copilot.vim",
        lazy = false,
        init = function()
            vim.g.copilot_no_tab_map = true
            vim.g.copilot_enabled = false
            vim.api.nvim_set_keymap("i", "<A-CR>", 'copilot#Accept("<CR>")', { silent = true, expr = true })
        end,

        keys = {
            { "<leader>cx", function() vim.g.copilot_enabled = not vim.g.copilot_enabled end, desc = "Toggle copilot" },
        },
    },
    {
        "CopilotC-Nvim/CopilotChat.nvim",
        branch = "canary",
        dependencies = {
            { "github/copilot.vim" },
            { "nvim-lua/plenary.nvim" },
        },
        opts = {
            window = {
                layout = "float",
                relative = "cursor",
                width = 1,
                height = 0.4,
                row = 1,
            },
        },
        keys = {
            { "<leader>cc", function() require("CopilotChat").toggle() end, desc = "Toggle copilot chat window" },
        },
    },
}
