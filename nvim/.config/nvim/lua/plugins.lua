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
nnoremap("<leader>ph")(":Gitsigns preview_hunk<CR>")

-- Fuzzy finding
local actions = require("fzf-lua.actions")
require("fzf-lua").setup({
    actions = {
        files = {
            ["default"] = actions.file_tabedit, -- Open in new tab by default
            ["ctrl-t"] = actions.file_edit, -- Open in current buffer with ctrl-t
        },
    },
})

-- Function to get the git root directory
local function get_git_root()
    vim.fn.execute("cd" .. vim.fn.expand("%:p:h"))
    local git_cmd = vim.fn.system("git rev-parse --show-toplevel 2> /dev/null")
    if vim.v.shell_error == 0 then
        return vim.fn.trim(git_cmd)
    else
        return nil
    end
end

-- Set the cwd based on whether git root exists or not
local git_root = get_git_root()
processed_cwd = git_root or vim.fn.expand("%:p:h")

nnoremap("<leader>ff")("<cmd>lua require('fzf-lua').files({ cwd = processed_cwd })<CR>")
nnoremap("<leader>fF")("<cmd>lua require('fzf-lua').files()<CR>")
nnoremap("<leader>fg")("<cmd>lua require('fzf-lua').grep_project()<CR>")
nnoremap("<leader>fs")("<cmd>lua require('fzf-lua').git_status()<CR>")

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
