return {
    { -- LSP Configuration & Plugins
        "neovim/nvim-lspconfig",
        event = "VeryLazy",
        dependencies = {
            -- Automatically install LSPs to stdpath for neovim
            { "williamboman/mason.nvim", event = "VeryLazy", opts = {} },
            { "williamboman/mason-lspconfig.nvim", event = "VeryLazy", opts = {} },
            { "WhoIsSethDaniel/mason-tool-installer.nvim", event = "VeryLazy" },

            -- Useful status updates for LSP
            { "j-hui/fidget.nvim", opts = {} },

            -- Additional lua configuration, makes nvim stuff amazing!
            "folke/lazydev.nvim",
        },
    },
    {
        "folke/lazydev.nvim",
        ft = "lua",
        opts = {},
    },
}
