-- Install Lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
    vim.fn.system({
        "git",
        "clone",
        "--filter=blob:none",
        "https://github.com/folke/lazy.nvim.git",
        "--branch=stable", -- latest stable release
        lazypath,
    })
end
vim.opt.rtp:prepend(lazypath)

require('lazy').setup({
    'ibhagwan/fzf-lua',
    'lewis6991/gitsigns.nvim',
    'nvim-lualine/lualine.nvim',
    'https://gitlab.com/k_lar/dark-pale-gruvbox-lualine.nvim',
    'https://gitlab.com/k_lar/gruvbox-pale',
    'folke/which-key.nvim',
    'echasnovski/mini.indentscope',
    'echasnovski/mini.move',
    'echasnovski/mini.comment',
    'echasnovski/mini.surround',
    'ggandor/leap.nvim',
    {'dhruvasagar/vim-table-mode', lazy = true},
    {'dkarter/bullets.vim', ft = "markdown"},
    {'nvim-treesitter/playground', lazy = true},

    { -- Highlight, edit, and navigate code
        'nvim-treesitter/nvim-treesitter',
        build = ':TSUpdate',
        lazy = true,
    }
}, {})
