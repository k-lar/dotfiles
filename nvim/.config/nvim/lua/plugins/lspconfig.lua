return {
    { -- LSP Configuration & Plugins
        "neovim/nvim-lspconfig",
        dependencies = {
            -- Automatically install LSPs to stdpath for neovim
            { "williamboman/mason.nvim", opts = {} },
            { "williamboman/mason-lspconfig.nvim", opts = {} },
            "WhoIsSethDaniel/mason-tool-installer.nvim",

            -- Useful status updates for LSP
            { "j-hui/fidget.nvim", opts = {} },

            -- Additional lua configuration, makes nvim stuff amazing!
            "folke/lazydev.nvim",
        },
    },
    {
        "folke/lazydev.nvim",
        ft = "lua",
        enabled = is_in_directory(vim.fn.expand("%:p"), vim.fn.stdpath("config")),
        opts = {},
    },
}
