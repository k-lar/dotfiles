require("utils")

-- Set undo break points for certain characters (sensible undo)
inoremap ',' ',<c-g>u'
inoremap '.' '.<c-g>u'
inoremap '!' '!<c-g>u'
inoremap '?' '?<c-g>u'

-- Spell checking
map '<leader>e' ':setlocal spell! spelllang=en_us<CR>' {silent = true} -- English
map '<leader>s' ':setlocal spell! spelllang=sl<CR>' {silent = true} -- Slovene

-- Tab controls (Alt+Left/Right)
nnoremap "<M-Left>" ":tabprevious<CR>"
nnoremap "<M-Right>" ":tabnext<CR>"

