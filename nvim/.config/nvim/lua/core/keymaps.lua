require("core.utils")

-- Set undo break points for certain characters (sensible undo)
inoremap(",")(",<c-g>u")
inoremap(".")(".<c-g>u")
inoremap("!")("!<c-g>u")
inoremap("?")("?<c-g>u")

-- Toggle netrw with SPC-n
nmap("<leader>n")(":lua ToggleNetrw()<CR>")({ silent = true, desc = "Toggle Netrw" })

-- Spell checking
map("<leader>e")(":setlocal spell! spelllang=en_us<CR>")({ silent = true }) -- English
map("<leader>s")(":setlocal spell! spelllang=sl_si<CR>")({ silent = true }) -- Slovene

-- Tab controls (Alt+Left/Right)
nnoremap("<M-Left>")(":tabprevious<CR>")
nnoremap("<M-Right>")(":tabnext<CR>")

-- Make gf keybind open files in new tab
nnoremap("gf")("<C-W>gf")

-- Toggle mouse on/off
nnoremap("<leader>M")(":lua ToggleMouse()<CR>")

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

-- My build script runner
-- stylua: ignore
vim.keymap.set("n", "<leader>b", "<cmd>BuildScript()<CR>", { desc = "Run build.sh in project root" })
