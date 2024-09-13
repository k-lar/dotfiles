-- Set undo break points for certain characters (sensible undo)
vim.keymap.set("i", ",", ",<c-g>u")
vim.keymap.set("i", ".", ".<c-g>u")
vim.keymap.set("i", "!", "!<c-g>u")
vim.keymap.set("i", "?", "?<c-g>u")

-- Spell checking
vim.keymap.set(
    "n",
    "<leader>Se",
    "<Cmd>setlocal spell! spelllang=en<CR>",
    { desc = "Toggle English spellchecking", silent = true }
) -- English

vim.keymap.set(
    "n",
    "<leader>Ss",
    "<Cmd>setlocal spell! spelllang=sl<CR>",
    { desc = "Toggle Slovene spellchecking", silent = true }
) -- Slovene

-- Tab controls (Alt+Left/Right)
vim.keymap.set("n", "<M-Left>", "<Cmd>tabprevious<CR>")
vim.keymap.set("n", "<M-Right>", "<Cmd>tabnext<CR>")

-- Make gf keybind open files in new tab
vim.keymap.set("n", "gf", "<C-W>gf")

-- Clear highlighting with Esc
vim.keymap.set("n", "<Esc>", "<Cmd>noh<CR>")

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

-- Better up and down
vim.keymap.set("n", "<Up>", "v:count == 0 ? 'gk' : 'k'", { desc = "Better Up", expr = true, silent = true })
vim.keymap.set("n", "k", "v:count == 0 ? 'gk' : 'k'", { desc = "Better Up", expr = true, silent = true })
vim.keymap.set("n", "<Down>", "v:count == 0 ? 'gj' : 'j'", { desc = "Better Down", expr = true, silent = true })
vim.keymap.set("n", "j", "v:count == 0 ? 'gj' : 'j'", { desc = "Better Down", expr = true, silent = true })

-- Window movement
vim.keymap.set("n", "<A-S-Left>", "<C-w><C-h>", { desc = "Move focus to the left window" })
vim.keymap.set("n", "<A-S-Right>", "<C-w><C-l>", { desc = "Move focus to the right window" })
vim.keymap.set("n", "<A-S-Down>", "<C-w><C-j>", { desc = "Move focus to the lower window" })
vim.keymap.set("n", "<A-S-Up>", "<C-w><C-k>", { desc = "Move focus to the upper window" })

-- Dynomark mappings
vim.keymap.set("n", "<leader>v", "<Plug>(DynomarkToggle)", { desc = "Toggle Dynomark" })
vim.keymap.set("n", "<leader>V", "<Plug>(DynomarkRun)", { desc = "Run dynomark query under cursor" })
