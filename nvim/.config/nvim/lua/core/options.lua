-- Map <leader> to space
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Turn on true colors
vim.o.termguicolors = true

-- Decrease update time
vim.opt.timeoutlen = 500
vim.opt.updatetime = 200

-- Nice defaults
vim.opt.compatible = false
vim.opt.encoding = "utf-8"
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.hidden = true
vim.opt.showmode = false
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.smarttab = true
vim.opt.smartindent = true
vim.opt.scrolloff = 1
vim.opt.sidescrolloff = 3
vim.opt.mouse = "a"
vim.opt.path = "**"
vim.opt.expandtab = true
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.undodir = vim.fn.stdpath("cache") .. "/undo/"
vim.opt.undofile = true
vim.opt.linebreak = true
vim.opt.breakindent = true
vim.opt.completeopt = "longest,menuone,noselect,popup"
vim.opt.autochdir = true
vim.opt.list = true
vim.opt.listchars = { tab = "» ", trail = "·", nbsp = "␣" }

-- Clipboard sync between nvim and OS (using vim.schedule() it decreases startup-time)
vim.schedule(function()
    vim.opt.clipboard = "unnamedplus"
end)

-- Splits open at the bottom and right, which is non-retarded, unlike vim defaults.
vim.opt.splitbelow = true
vim.opt.splitright = true

-- Native autocompletion config (omnifunc)
vim.opt.wildmode = { "longest", "list", "full" }
vim.opt.wildignore = { "*.pdf", "*.docx" }
vim.opt.omnifunc = "syntaxcomplete#Complete"

-- Netrw config
vim.g.netrw_liststyle = 3
vim.g.netrw_banner = 0
vim.g.netrw_browse_split = 4
vim.g.netrw_winsize = 25
vim.g.NetrwIsOpen = false

-- Enable native EditorConfig support
vim.g.editorconfig = 1

-- Enable support for nerd fonts
vim.g.have_nerd_font = true

-- Needed for fallback of moving lines up and down
vim.g.mini_move_loaded = false

-- For detecting if a plugin for a colorscheme has been used
vim.g.custom_colorscheme_loaded = false

-- Autoformatting flags
vim.b.autoformat = true
vim.g.autoformat = true

-- Disables automatic commenting on new line
vim.api.nvim_create_autocmd({ "FileType" }, {
    pattern = "*",
    callback = function()
        vim.opt.formatoptions:remove({ "c", "r", "o" })
    end,
})
