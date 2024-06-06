return {
    { "nvim-treesitter/playground", lazy = true },
    { -- Highlight, edit, and navigate code
        "nvim-treesitter/nvim-treesitter",
        build = ":TSUpdate",
        opts = {
            auto_install = true,
            sync_install = false,
            ignore_install = {},
            ensure_installed = {
                "c",
                "lua",
                "python",
                "bash",
                "bibtex",
                "cpp",
                "yaml",
                "vim",
                "cmake",
                "latex",
                "go",
                "typescript",
                "javascript",
                "vue",
                "css",
                "tsx",
            },
            highlight = { enable = true },
            indent = { enable = false },
            incremental_selection = {
                enable = true,
                keymaps = {
                    init_selection = "vv",
                    node_incremental = "vv",
                    node_decremental = "vV",
                },
            },
        },
        config = function(_, opts)
            -- Prefer git instead of curl in order to improve connectivity in some environments
            require("nvim-treesitter.install").prefer_git = true
            ---@diagnostic disable-next-line: missing-fields
            require("nvim-treesitter.configs").setup(opts)
        end,
    },
}
