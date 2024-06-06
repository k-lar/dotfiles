require("core.utils")

-- Map <leader> to space
g.mapleader = " "
g.maplocalleader = " "

-- Turn on true colors
o.termguicolors = true

-- Decrease update time
o.timeoutlen = 500
o.updatetime = 200

-- Nice defaults
o.compatible = false
o.encoding = "utf-8"
o.number = true
o.relativenumber = true
o.clipboard = "unnamedplus"
o.hidden = true
o.showmode = false
o.ignorecase = true
o.smartcase = true
o.smarttab = true
o.smartindent = true
o.scrolloff = 1
o.sidescrolloff = 3
o.mouse = "a"
o.path = "**"
o.expandtab = true
o.tabstop = 4
o.shiftwidth = 4
o.undofile = true
o.linebreak = true
o.breakindent = true
o.completeopt = "menuone,noselect"
o.autochdir = true

-- Splits open at the bottom and right, which is non-retarded, unlike vim defaults.
o.splitbelow = true
o.splitright = true

-- Native autocompletion config (omnifunc)
o.wildmode = { "longest", "list", "full" }
o.wildignore = { "*.pdf", "*.docx" }
o.omnifunc = "syntaxcomplete#Complete"

-- Netrw config
g.netrw_liststyle = 3
g.netrw_banner = 0
g.netrw_browse_split = 4
g.netrw_winsize = 25
g.NetrwIsOpen = false

-- Disables automatic commenting on new line
vim.cmd("autocmd FileType * setlocal formatoptions-=c formatoptions-=r formatoptions-=o")
