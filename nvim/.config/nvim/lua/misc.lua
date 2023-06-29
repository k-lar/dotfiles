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

-- Highlight on yank
local group = vim.api.nvim_create_augroup('user_cmds', {clear = true})

vim.api.nvim_create_autocmd('TextYankPost', {
    desc = 'Highlight on yank',
    group = group,
    callback = function()
        vim.highlight.on_yank({higroup = 'Visual', timeout = 200})
    end,
})

-- Quick exit from help docs
vim.api.nvim_create_autocmd('FileType', {
    pattern = {'help', 'man', 'checkhealth'},
    group = group,
    command = 'nnoremap <buffer> q <cmd>quit<cr>'
})
