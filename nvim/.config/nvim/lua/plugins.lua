require("utils")

-- Configure Treesitter
local configs = require("nvim-treesitter.configs")
configs.setup({
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

    highlight = { -- enable highlighting
        enable = true,
    },

    indent = {
        enable = false, -- default is disabled anyways
    },

    incremental_selection = {
        enable = true,
        keymaps = {
            init_selection = "vv",
            node_incremental = "vv",
            node_decremental = "vV",
        },
    },
})

-- Enable gitsigns
require("gitsigns").setup({
    signcolumn = false,
})
nnoremap("<leader>G")(":Gitsigns toggle_signs<CR>") -- SPC-Shift-g toggle gitsigns
nnoremap("<leader>gp")(":Gitsigns prev_hunk<CR>")
nnoremap("<leader>gn")(":Gitsigns next_hunk<CR>")
nnoremap("<leader>gs")(":Gitsigns stage_hunk<CR>")
nnoremap("<leader>gu")(":Gitsigns undo_stage_hunk<CR>")
nnoremap("<leader>ph")(":Gitsigns preview_hunk<CR>")

-- Gitsigns config
require("gitsigns").setup({ signcolumn = false })
nnoremap("<leader>G")(":Gitsigns toggle_signs<CR>")

-- which-key config
require("which-key").setup()

-- TreeSitter Playground config
require("nvim-treesitter.configs").setup({})

-- Table mode
g.table_mode_corner = "|"

-- Emmet / HTML settings
g.user_emmet_mode = "n"
g.user_emmet_leader_key = ","

-- Bullets.vim
g.bullets_renumber_on_change = 0

-- mini.move plugin setup
require("mini.move").setup({
    mappings = {
        -- Move visual selection in Visual mode. Defaults are Alt (Meta) + hjkl.
        left = "<C-Left>",
        right = "<C-Right>",
        down = "<C-Down>",
        up = "<C-Up>",

        -- Move current line in Normal mode
        line_left = "<C-Left>",
        line_right = "<C-Right>",
        line_down = "<C-Down>",
        line_up = "<C-Up>",
    },
})

-- mini.pairs plugin setup (disable pairing ' symbol in certain filetypes)
vim.cmd([[autocmd FileType markdown,plaintext,latex,tex inoremap ' ']])

-- conform.nvim formatter setup
require("conform").setup({
    formatters_by_ft = {
        lua = { "stylua" },
        -- Conform will run multiple formatters sequentially
        python = { "black" },
        go = { "gofmt", "goimports" },
        -- Use a sub-list to run only the first available formatter
        javascript = { { "prettierd", "prettier" } },
    },
})

-- Autoformat on save
vim.api.nvim_create_autocmd("BufWritePre", {
    pattern = "*",
    callback = function(args) require("conform").format({ bufnr = args.buf }) end,
})
