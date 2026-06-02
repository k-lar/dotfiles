local blink = try_require("blink.cmp")
if not blink then
    return
end

-- Toggle completion on/off (mirrors vim.g.cmptoggle from nvim-cmp)
vim.g.cmptoggle = true
vim.keymap.set("n", "<leader>tc", function()
    vim.g.cmptoggle = not vim.g.cmptoggle
    vim.notify("Completion: " .. (vim.g.cmptoggle and "on" or "off"))
end, { desc = "Toggle completion" })

blink.setup({
    enabled = function()
        return vim.g.cmptoggle and vim.bo.buftype ~= "prompt"
    end,

    keymap = {
        preset = "default",
        -- Arrow keys should only move the cursor, not select completion items
        ["<Up>"] = { "fallback" },
        ["<Down>"] = { "fallback" },
        -- Use Tab and Shift-Tab to navigate completion items and snippets
        ["<S-Tab>"] = { "select_prev", "snippet_backward", "fallback" },
        ["<Tab>"] = { "select_next", "snippet_forward", "fallback" },
        -- Hide autocomplete with ESC
        ["<Esc>"] = { "hide", "fallback" },
        -- Scroll docs
        ["<PageUp>"] = { "scroll_documentation_up", "fallback" },
        ["<PageDown>"] = { "scroll_documentation_down", "fallback" },
        -- Confirm with <S-CR>
        ["<S-CR>"] = { "accept", "fallback" },
    },

    sources = {
        default = { "lsp", "path", "snippets", "buffer", "emoji" },
        providers = {
            emoji = {
                module = "blink-emoji",
                name = "Emoji",
                score_offset = -1,
            },
        },
    },

    completion = {
        documentation = {
            auto_show = true,
            auto_show_delay_ms = 200,
            window = { border = "rounded" },
        },
        menu = {
            border = "rounded",
        },
    },

    fuzzy = {
        implementation = "lua",
    },
})
