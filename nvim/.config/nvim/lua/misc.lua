require("utils")

-- Set undo break points for certain characters (sensible undo)
inoremap ',' ',<c-g>u'
inoremap '.' '.<c-g>u'
inoremap '!' '!<c-g>u'
inoremap '?' '?<c-g>u'

-- Spell checking
map '<leader>e' ':setlocal spell! spelllang=en_us<CR>' {silent = true} -- English
map '<leader>s' ':setlocal spell! spelllang=sl<CR>' {silent = true} -- Slovene

-- Move lines up and down
nnoremap '<c-Down>' ":m .+1<CR>=="
nnoremap '<c-Up>'   ":m .-2<CR>=="
inoremap '<c-Down>' "<ESC>:m .+1<CR>==gi"
inoremap '<c-Up>'   "<ESC>:m .-2<CR>==gi"
vnoremap '<c-Down>' ":m '>+1<CR>gv=gv"
vnoremap '<c-Up>'   ":m '<-2<CR>gv=gv"

-- Tab controls (Alt+Left/Right)
nnoremap "<M-Left>" ":tabprevious<CR>"
nnoremap "<M-Right>" ":tabnext<CR>"

