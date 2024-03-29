require("utils")

-- Set undo break points for certain characters (sensible undo)
inoremap(",")(",<c-g>u")
inoremap(".")(".<c-g>u")
inoremap("!")("!<c-g>u")
inoremap("?")("?<c-g>u")

-- Spell checking
map("<leader>e")(":setlocal spell! spelllang=en_us<CR>")({ silent = true }) -- English
map("<leader>s")(":setlocal spell! spelllang=sl_si<CR>")({ silent = true }) -- Slovene

-- Tab controls (Alt+Left/Right)
nnoremap("<M-Left>")(":tabprevious<CR>")
nnoremap("<M-Right>")(":tabnext<CR>")

-- Make gf keybind open files in new tab
nnoremap("gf")("<C-W>gf")

-- Highlight on yank
local group = vim.api.nvim_create_augroup("user_cmds", { clear = true })

vim.api.nvim_create_autocmd("TextYankPost", {
    desc = "Highlight on yank",
    group = group,
    callback = function() vim.highlight.on_yank({ higroup = "Visual", timeout = 200 }) end,
})

-- Quick exit from help docs
vim.api.nvim_create_autocmd("FileType", {
    pattern = { "help", "man", "checkhealth" },
    group = group,
    command = "nnoremap <buffer> q <cmd>quit<cr>",
})

-- Better keybindings for object operations
-- Use b for () and B for {}
-- Example: cib, diB
vim.keymap.set("o", "ar", "a]") -- [r]ectangular bracket
vim.keymap.set("v", "ar", "a]")
vim.keymap.set("o", "ir", "i]")
vim.keymap.set("v", "ir", "i]")

vim.keymap.set("o", "ac", "a}") -- [c]urly brace
vim.keymap.set("v", "ac", "a}")
vim.keymap.set("o", "ic", "i}")
vim.keymap.set("v", "ic", "i}")

vim.keymap.set("o", "am", "aW") -- [m]assive word (= no shift needed)
vim.keymap.set("o", "im", "iW")

vim.keymap.set("o", "aq", 'a"') -- [q]uote
vim.keymap.set("v", "aq", 'a"')
vim.keymap.set("o", "iq", 'i"')
vim.keymap.set("v", "iq", 'i"')

vim.keymap.set("o", "az", "a'") -- [z]ingle quote
vim.keymap.set("v", "az", "a'")
vim.keymap.set("o", "iz", "i'")
vim.keymap.set("v", "iz", "i'")

-- Create "line" objects
vim.keymap.set("x", "il", "g_o0")
vim.keymap.set("o", "il", ":normal vil<CR>")

-- Easier end of line movement in visual mode
vim.keymap.set("v", "E", "$")

-- Show color column at 80 characters if cursor position is more than 70
vim.api.nvim_create_autocmd({"CursorMoved", "CursorMovedI"}, {
    pattern = "*",
    callback = function()
        local col = vim.fn.virtcol(".")
        if col > 70 and col < 82 then
            o.colorcolumn = "80"
        elseif col > 110 then
            o.colorcolumn = "120"
        else
            o.colorcolumn = ""
        end
    end,
})
