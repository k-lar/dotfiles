local mini_comment = try_require("mini.comment")
if mini_comment then
    mini_comment.setup()
end

local mini_indentscope = try_require("mini.indentscope")
if mini_indentscope then
    mini_indentscope.setup({ symbol = "│" })
end

local mini_surround = try_require("mini.surround")
if mini_surround then
    mini_surround.setup()
end

local mini_icons = try_require("mini.icons")
if mini_icons then
    mini_icons.setup()
end

local mini_move = try_require("mini.move")
if mini_move then
    mini_move.setup({
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
else
    vim.keymap.set("i", "<C-Down>", "<Esc>:m .+1<CR>==gi", { desc = "Move the line down", silent = true })
    vim.keymap.set("i", "<C-Up>", "<Esc>:m .-2<CR>==gi", { desc = "Move the line up", silent = true })
    vim.keymap.set("n", "<C-Down>", "<cmd>m+<CR>==", { desc = "Move the line down", silent = true })
    vim.keymap.set("n", "<C-Up>", "<cmd>m-2<CR>==", { desc = "Move the line up", silent = true })
    vim.keymap.set("v", "<C-Up>", ":m '<-2<CR>gv=gv", { desc = "Move the selected text up", noremap = true, silent = true })
    vim.keymap.set("v", "<C-Down>",":m '>+1<CR>gv=gv",{ desc = "Move the selected text down", noremap = true, silent = true })
    vim.keymap.set("n", "<C-Right>", "<Cmd>>><CR>", { desc = "Indent the line", silent = true })
    vim.keymap.set("n", "<C-Left>", "<Cmd><<<CR>", { desc = "Dedent the line", silent = true })
    vim.keymap.set("i", "<C-Right>", "<Esc>:>><CR>i", { desc = "Indent the line", silent = true })
    vim.keymap.set("i", "<C-Left>", "<Esc>:<<<CR>i", { desc = "Dedent the line", silent = true })
end
