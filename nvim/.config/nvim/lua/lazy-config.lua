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

require("lazy").setup({
    "ibhagwan/fzf-lua",
    "lewis6991/gitsigns.nvim",
    "nvim-lualine/lualine.nvim",
    "https://gitlab.com/k_lar/dark-pale-gruvbox-lualine.nvim",
    "https://gitlab.com/k_lar/gruvbox-pale",
    "folke/which-key.nvim",
    "stevearc/conform.nvim",
    "ggandor/leap.nvim",
    "echasnovski/mini.move",
    { "vidocqh/auto-indent.nvim", opts = {} },
    { "echasnovski/mini.pairs", opts = {} },
    { "echasnovski/mini.indentscope", opts = {} },
    { "echasnovski/mini.comment", opts = {} },
    { "echasnovski/mini.surround", opts = {} },
    { "dhruvasagar/vim-table-mode", lazy = true },
    { "dkarter/bullets.vim", ft = "markdown" },
    { "nvim-treesitter/playground", lazy = true },
    {
        "folke/todo-comments.nvim",
        opts = {
            keywords = {
                TODO = { color = "hint" },
                NOTE = { color = "info" },
            },
        },
    },
    { -- Highlight, edit, and navigate code
        "nvim-treesitter/nvim-treesitter",
        build = ":TSUpdate",
        lazy = true,
    },
}, {})
