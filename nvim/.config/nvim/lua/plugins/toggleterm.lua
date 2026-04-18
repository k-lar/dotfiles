local toggleterm = try_require("toggleterm")
if not toggleterm then return end

toggleterm.setup({
    size = function(term)
        if term.direction == "horizontal" then
            return 15
        elseif term.direction == "vertical" then
            return vim.o.columns * 0.4
        end
    end,
    highlights = {
        Normal      = { link = "Normal" },
        NormalFloat = { link = "Normal" },
        FloatBorder = { link = "FloatBorder" },
    },
    start_in_insert  = true,
    insert_mappings  = true,
    persist_size     = true,
    direction        = "horizontal",
    close_on_exit    = true,
    shell            = vim.o.shell,
    float_opts = {
        border   = "curved",
        width    = math.floor(0.7 * vim.fn.winwidth(0)),
        height   = math.floor(0.8 * vim.fn.winheight(0)),
        winblend = 4,
    },
    winbar = { enabled = true },
})

-- Lazygit: fullscreen float
local Terminal  = require("toggleterm.terminal").Terminal
local lazygit   = Terminal:new({
    cmd        = "lazygit",
    hidden     = true,
    direction  = "float",
    float_opts = { width = vim.o.columns, height = vim.o.lines },
})
local lazydocker = Terminal:new({ cmd = "sudo lazydocker", hidden = true, direction = "float" })

function _lazygit_toggle()   lazygit:toggle()   end   ---@diagnostic disable-line
function _lazydocker_toggle() lazydocker:toggle() end  ---@diagnostic disable-line

-- <Esc> exits terminal mode
vim.keymap.set("t", "<Esc>", [[<C-\><C-n>]], { desc = "Exit terminal mode" })

-- Per-terminal-buffer window-navigation keymaps
local function set_terminal_keymaps()
    local opts = { buffer = 0, noremap = true }
    vim.keymap.set("t", "<C-x>",     [[<C-\><C-n>]],         opts)
    vim.keymap.set("t", "<C-Left>",  [[<C-\><C-n><C-W>h]],   opts)
    vim.keymap.set("t", "<C-Down>",  [[<C-\><C-n><C-W>j]],   opts)
    vim.keymap.set("t", "<C-Up>",    [[<C-\><C-n><C-W>k]],   opts)
    vim.keymap.set("t", "<C-Right>", [[<C-\><C-n><C-W>l]],   opts)
end

vim.api.nvim_create_autocmd("TermOpen", {
    pattern  = "term://*toggleterm#*",
    callback = set_terminal_keymaps,
})

-- Keymaps
vim.keymap.set("n", "<leader>x",  "<cmd>ToggleTerm<CR>",        { desc = "Toggle terminal" })
vim.keymap.set("n", "<leader>gg", function() _lazygit_toggle() end,    { desc = "Toggle lazygit" })
vim.keymap.set("n", "<leader>ld", function() _lazydocker_toggle() end, { desc = "Toggle lazydocker" })
