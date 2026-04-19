local neogen = try_require("neogen")
if neogen then
    neogen.setup()
end

local flash = try_require("flash")
if flash then
    flash.setup({
        search = {
            multi_window = false,
        },
        modes = {
            search = {
                enabled = false,
            },
        },
    })

    -- stylua: ignore start
    vim.keymap.set({ "n", "x", "o" }, "<Enter>",   function() flash.jump()              end, { desc = "Flash" })
    vim.keymap.set({ "n", "x", "o" }, "<S-Enter>", function() flash.treesitter()        end, { desc = "Flash Treesitter" })
    vim.keymap.set("o",               "r",         function() flash.remote()            end, { desc = "Remote Flash" })
    vim.keymap.set({ "o", "x" },      "R",         function() flash.treesitter_search() end, { desc = "Treesitter Search" })
    vim.keymap.set("c",               "<C-s>",     function() flash.toggle()            end, { desc = "Toggle Flash Search" })
    -- stylua: ignore end
end

local todo_comments = try_require("todo-comments")
if todo_comments then
    todo_comments.setup({
        signs = false,
        keywords = {
            TODO = { color = "hint" },
            NOTE = { color = "info" },
        },
    })
end

local highlight_colors = try_require("nvim-highlight-colors")
if highlight_colors then
    highlight_colors.setup({
        render = "virtual",
        virtual_symbol_position = "eol",
        virtual_symbol = "■",
        virtual_symbol_suffix = " ",
        virtual_symbol_prefix = "",
        enable_tailwind = true,
    })
end

local comfy_line_numbers = try_require("comfy-line-numbers")
if comfy_line_numbers then
    comfy_line_numbers.setup({
        up_key = "<Up>",
        down_key = "<Down>",
    })
end
