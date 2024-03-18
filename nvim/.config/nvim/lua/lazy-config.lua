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
    "lewis6991/gitsigns.nvim",
    "nvim-lualine/lualine.nvim",
    "folke/which-key.nvim",
    "stevearc/conform.nvim",
    "echasnovski/mini.move",
    "tpope/vim-sleuth",
    "dkarter/bullets.vim",
    "github/copilot.vim",
    "nvim-lua/plenary.nvim",
    { "vidocqh/auto-indent.nvim", opts = {} },
    { "echasnovski/mini.indentscope", opts = {} },
    { "echasnovski/mini.comment", opts = {} },
    { "echasnovski/mini.surround", opts = {} },
    { "dhruvasagar/vim-table-mode", ft = "plaintext", "markdown" },
    { "nvim-treesitter/playground", lazy = true },
    { "akinsho/toggleterm.nvim", version = "*", config = true },
    {
        "nvim-telescope/telescope.nvim",
        branch = "0.1.x",
        dependencies = {
            "nvim-lua/plenary.nvim",
            {
                "nvim-telescope/telescope-fzf-native.nvim",
                build = "make",
                cond = function() return vim.fn.executable("make") == 1 end,
            },
        },
    },
    {
        "windwp/nvim-autopairs",
        event = "InsertEnter",
        opts = {},
    },
    {
        "ThePrimeagen/harpoon",
        branch = "harpoon2",
        requires = { "nvim-lua/plenary.nvim" }
    },
    {
        "ribru17/bamboo.nvim",
        lazy = false,
        priority = 1000,
        config = function()
            require("bamboo").setup({
                style = "multiplex",
                code_style = {
                    comments = "none",
                    conditionals = "none",
                    keywords = "none",
                    functions = "bold",
                    namespaces = "none",
                    parameters = "none",
                    strings = "none",
                    variables = "none",
                },
                highlights = {
                    ["@comment"] = { fg = "$grey" },
                },
            })
            require("bamboo").load()
        end,
    },
    {
        "folke/flash.nvim",
        event = "VeryLazy",
        ---@type Flash.Config
        opts = {},
        -- stylua: ignore
        keys = {
            { "<Enter>", mode = { "n", "x", "o" }, function() require("flash").jump() end, desc = "Flash" },
            { "<S-Enter>", mode = { "n", "x", "o" }, function() require("flash").treesitter() end, desc = "Flash Treesitter" },
            { "r", mode = "o", function() require("flash").remote() end, desc = "Remote Flash" },
            { "R", mode = { "o", "x" }, function() require("flash").treesitter_search() end, desc = "Treesitter Search" },
            { "<c-s>", mode = { "c" }, function() require("flash").toggle() end, desc = "Toggle Flash Search" },
        },
    },
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
    { -- LSP Configuration & Plugins
        "neovim/nvim-lspconfig",
        dependencies = {
            -- Automatically install LSPs to stdpath for neovim
            "williamboman/mason.nvim",
            "williamboman/mason-lspconfig.nvim",

            -- Useful status updates for LSP
            { "j-hui/fidget.nvim", opts = {} },

            -- Additional lua configuration, makes nvim stuff amazing!
            "folke/neodev.nvim",
        },
    },
    { -- Autocompletion
        "hrsh7th/nvim-cmp",
        dependencies = {
            -- Snippet Engine & its associated nvim-cmp source
            "L3MON4D3/LuaSnip",
            "saadparwaiz1/cmp_luasnip",

            -- Adds LSP completion capabilities
            "hrsh7th/cmp-nvim-lsp",

            -- Adds local buffer symbol completion
            "hrsh7th/cmp-buffer",

            -- Adds a number of user-friendly snippets
            "rafamadriz/friendly-snippets",
        },
    },
}, {})
