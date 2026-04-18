local treesitter = try_require("nvim-treesitter.configs")
if not treesitter then
    return
end

require("nvim-treesitter.install").prefer_git = true

---@diagnostic disable-next-line: missing-fields
treesitter.setup({
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
})
