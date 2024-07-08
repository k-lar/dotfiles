return {
    {
        "dhruvasagar/vim-table-mode",
        ft = { "plaintext", "markdown" },
        config = function() vim.g.table_mode_corner = "|" end,
    },
    {
        "dkarter/bullets.vim",
        ft = { "plaintext", "markdown" },
        config = function() vim.g.bullets_renumber_on_change = 0 end,
    },
}
