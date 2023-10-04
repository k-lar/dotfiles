require("utils")

-- Map <leader> to space
g.mapleader = " "
g.maplocalleader = " "

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

-- Splits open at the bottom and right, which is non-retarded, unlike vim defaults.
o.splitbelow = true
o.splitright = true

-- Native autocompletion config (omnifunc)
o.wildmode = { "longest", "list", "full" }
o.wildignore = { "*.pdf", "*.docx" }
o.omnifunc = "syntaxcomplete#Complete"

-- Disables automatic commenting on new line
vim.cmd("autocmd FileType * setlocal formatoptions-=c formatoptions-=r formatoptions-=o")
