return {
    {
        "dhruvasagar/vim-table-mode",
        ft = { "plaintext", "markdown" },
        config = function() g.table_mode_corner = "|" end,
    },
    {
        "dkarter/bullets.vim",
        ft = { "plaintext", "markdown" },
        config = function() g.bullets_renumber_on_change = 0 end,
    },
}
