require("utils")

-- Enable mini.comment plugin
require('mini.comment').setup()

-- Configure Treesitter
local configs = require'nvim-treesitter.configs'
configs.setup {
    ensure_installed = {
        "c", "lua", "python",
        "bash", "bibtex", "cpp",
        "yaml", "vim", "cmake", "latex",
        "go", "typescript", "javascript"
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
nnoremap '<leader>gp' ':Gitsigns prev_hunk<CR>'
nnoremap '<leader>gn' ':Gitsigns next_hunk<CR>'
nnoremap '<leader>ph' ':Gitsigns preview_hunk<CR>'

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

-- mini.move plugin setup
require('mini.move').setup({
  mappings = {
    -- Move visual selection in Visual mode. Defaults are Alt (Meta) + hjkl.
    left = '<C-Left>',
    right = '<C-Right>',
    down = '<C-Down>',
    up = '<C-Up>',

    -- Move current line in Normal mode
    line_left = '<C-Left>',
    line_right = '<C-Right>',
    line_down = '<C-Down>',
    line_up = '<C-Up>',
  },
})
