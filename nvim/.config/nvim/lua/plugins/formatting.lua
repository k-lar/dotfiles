vim.api.nvim_create_user_command("FormatDisable", function(args)
    if args.bang then
        -- FormatDisable! will disable formatting just for this buffer
        vim.b.autoformat = false
    else
        vim.g.autoformat = false
    end
end, {
    desc = "Disable autoformat-on-save",
    bang = true,
})

vim.api.nvim_create_user_command("FormatEnable", function()
    vim.b.autoformat = true
    vim.g.autoformat = true
end, {
    desc = "Re-enable autoformat-on-save",
})

vim.keymap.set("n", "<leader>Fe", "<Cmd>FormatEnable<CR>", { desc = "Re-enable autoformat-on-save" })
vim.keymap.set("n", "<leader>Fd", "<Cmd>FormatDisable<CR>", { desc = "Disable autoformat-on-save" })

vim.keymap.set("n", "<leader>Ft", function()
    vim.b.autoformat = not vim.b.autoformat
    vim.notify("Autoformat on buffer: " .. tostring(vim.b.autoformat), vim.log.levels.INFO)
end, { desc = "Toggle autoformat in this buffer" })

vim.keymap.set("n", "<leader>FT", function()
    vim.g.autoformat = not vim.g.autoformat
    vim.notify("Autoformat globaly: " .. tostring(vim.g.autoformat), vim.log.levels.INFO)
end, { desc = "Toggle autoformat in all buffers" })

return {
    { "tpope/vim-sleuth" },
    {
        "stevearc/conform.nvim",
        opts = {
            notify_on_error = false,
            formatters_by_ft = {
                lua = { "stylua" },
                -- Conform will run multiple formatters sequentially
                python = { "black" },
                go = { "gofmt", "goimports" },
                -- Use a sub-list to run only the first available formatter
                javascript = { "prettierd", "prettier", "biome", stop_after_first = true },
            },
            format_on_save = function(bufnr)
                local disable_filetypes = { c = true, cpp = true }
                -- Disable with a global or buffer-local variable
                if vim.g.autoformat == false or vim.b[bufnr].autoformat == false then
                    return
                end

                return {
                    timeout_ms = 500,
                    lsp_fallback = not disable_filetypes[vim.bo[bufnr].filetype],
                }
            end,
        },
    },
    {
        "windwp/nvim-autopairs",
        event = "InsertEnter",
        -- Optional dependency
        dependencies = { "hrsh7th/nvim-cmp" },
        config = function()
            require("nvim-autopairs").setup({})
            -- If you want to automatically add `(` after selecting a function or method
            local cmp_autopairs = require("nvim-autopairs.completion.cmp")
            local cmp = require("cmp")
            cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done())
        end,
    },
}
