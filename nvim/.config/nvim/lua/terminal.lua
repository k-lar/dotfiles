require("utils")

require("toggleterm").setup({
    -- size can be a number or function which is passed the current terminal
    size = function(term)
        if term.direction == "horizontal" then
            return 15
        elseif term.direction == "vertical" then
            return vim.o.columns * 0.4
        end
    end,
    highlights = {
        -- highlights which map to a highlight group name and a table of it's values
        -- NOTE: this is only a subset of values, any group placed here will be set for the terminal window split
        Normal = {
            link = "Normal",
        },
        NormalFloat = {
            link = "Normal",
        },
        FloatBorder = {
            link = "FloatBorder",
        },
    },
    start_in_insert = true,
    insert_mappings = true, -- whether or not the open mapping applies in insert mode
    persist_size = true,
    direction = "horizontal", -- | 'horizontal' | 'window' | 'float',
    close_on_exit = true, -- close the terminal window when the process exits
    shell = vim.o.shell, -- change the default shell
    -- This field is only relevant if direction is set to 'float'
    float_opts = {
        -- The border key is *almost* the same as 'nvim_win_open'
        -- see :h nvim_win_open for details on borders however
        -- the 'curved' border is a custom border type
        -- not natively supported but implemented in this plugin.
        border = "curved", -- single/double/shadow/curved
        width = math.floor(0.7 * vim.fn.winwidth(0)),
        height = math.floor(0.8 * vim.fn.winheight(0)),
        winblend = 4,
    },
    winbar = {
        enabled = true,
    },
})

local Terminal = require("toggleterm.terminal").Terminal
local lazygit = Terminal:new({
    cmd = "lazygit",
    hidden = true,
    direction = "float",
    float_opts = { width = vim.o.columns, height = vim.o.lines },
})
local lazydocker = Terminal:new({ cmd = "sudo lazydocker", hidden = true, direction = "float" })

---@diagnostic disable-next-line
function _lazygit_toggle() lazygit:toggle() end

---@diagnostic disable-next-line
function _lazydocker_toggle() lazydocker:toggle() end

function _G.set_terminal_keymaps()
    local opts = { noremap = true }
    vim.api.nvim_buf_set_keymap(0, "t", "<C-x>", [[<C-\><C-n>]], opts)
    vim.api.nvim_buf_set_keymap(0, "t", "<C-Left>", [[<C-\><C-n><C-W>h]], opts)
    vim.api.nvim_buf_set_keymap(0, "t", "<C-Down>", [[<C-\><C-n><C-W>j]], opts)
    vim.api.nvim_buf_set_keymap(0, "t", "<C-Up>", [[<C-\><C-n><C-W>k]], opts)
    vim.api.nvim_buf_set_keymap(0, "t", "<C-Right>", [[<C-\><C-n><C-W>l]], opts)
end

vim.cmd("autocmd! TermOpen term://*toggleterm#* lua set_terminal_keymaps()")

nnoremap("<leader>x")("<cmd>ToggleTerm<CR>")
nnoremap("<leader>gg")("<cmd>lua _lazygit_toggle()<CR>")
nnoremap("<leader>ld")("<cmd>lua _lazydocker_toggle()<CR>")
