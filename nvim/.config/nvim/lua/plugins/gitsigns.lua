local gitsigns = try_require("gitsigns")
if not gitsigns then
    return
end

gitsigns.setup({
    signcolumn = false,
    signs = {
        add          = { text = "+" },
        change       = { text = "~" },
        delete       = { text = "_" },
        topdelete    = { text = "‾" },
        changedelete = { text = "~" },
    },
})

-- stylua: ignore start
vim.keymap.set("n", "<leader>G",  function() gitsigns.toggle_signs()     end, { desc = "Toggle gitgutter signs" })
vim.keymap.set("n", "<leader>gp", function() gitsigns.prev_hunk()        end, { desc = "Previous hunk" })
vim.keymap.set("n", "<leader>gn", function() gitsigns.next_hunk()        end, { desc = "Next hunk" })
vim.keymap.set("n", "<leader>gs", function() gitsigns.stage_hunk()       end, { desc = "Stage hunk" })
vim.keymap.set("n", "<leader>gr", function() gitsigns.reset_hunk()       end, { desc = "Reset hunk" })
vim.keymap.set("n", "<leader>gu", function() gitsigns.undo_stage_hunk()  end, { desc = "Undo staged hunk" })
vim.keymap.set("n", "<leader>gh", function() gitsigns.preview_hunk()     end, { desc = "Preview hunk" })
-- stylua: ignore end
