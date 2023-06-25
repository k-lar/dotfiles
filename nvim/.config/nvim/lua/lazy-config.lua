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
    'numToStr/Comment.nvim',
    'nvim-lualine/lualine.nvim',
    'ggandor/leap.nvim',
    'https://gitlab.com/k_lar/dark-pale-gruvbox-lualine.nvim',
    'https://gitlab.com/k_lar/gruvbox-pale',
    'dkarter/bullets.vim',
    'dhruvasagar/vim-table-mode',
    'echasnovski/mini.indentscope',
    'folke/which-key.nvim',
    'echasnovski/mini.move',
    'nvim-treesitter/playground',

    {
        -- Highlight, edit, and navigate code
        'nvim-treesitter/nvim-treesitter',
        dependencies = {
            'nvim-treesitter/nvim-treesitter-textobjects',
        },
        build = ':TSUpdate',
    }
}, {})
