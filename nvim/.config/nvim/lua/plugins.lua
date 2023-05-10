require("utils")

-- Enable Comment.nvim
require('Comment').setup()

-- Configure Treesitter
local configs = require'nvim-treesitter.configs'
configs.setup {
    ensure_installed = {
        "c", "lua", "python",
        "bash", "bibtex", "cpp",
        "yaml", "vim", "cmake", "latex",
        "go",
    },

    highlight = { -- enable highlighting
        enable = true,
    },

    indent = {
        enable = false, -- default is disabled anyways
    }
}

-- Enable leap
require('leap').add_default_mappings()

-- Enable gitsigns
require('gitsigns').setup {
    signcolumn = false
}
nnoremap '<leader>G' ':Gitsigns toggle_signs<CR>' -- SPC-Shift-g toggle gitsigns

-- Fuzzy finding
local actions = require "fzf-lua.actions"
require('fzf-lua').setup {
  actions = {
    files = {
        ["default"] = actions.file_tabedit, -- Open in new tab by default
        ["ctrl-t"] = actions.file_edit      -- Open in current buffer with ctrl-t
    }
  }
}
nnoremap "<leader>ff" "<cmd>lua require('fzf-lua').files()<CR>"
nnoremap "<leader>fg" "<cmd>lua require('fzf-lua').grep_project()<CR>"
nnoremap "<leader>fs" "<cmd>lua require('fzf-lua').git_status()<CR>"

-- Gitsigns config
require('gitsigns').setup {signcolumn = false}
nnoremap '<leader>G' ':Gitsigns toggle_signs<CR>'

-- mini.indentscope config
require('mini.indentscope').setup()

-- which-key config
require('which-key').setup()

-- TreeSitter Playground config
require('nvim-treesitter.configs').setup({})

-- Table mode
g.table_mode_corner = '|'

-- Emmet / HTML settings
g.user_emmet_mode = "n"
g.user_emmet_leader_key = ","

-- Bullets.vim
g.bullets_renumber_on_change = 0

