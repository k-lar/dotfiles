--[[
   _    _           ( )        _        _  _       _
  | |__| | __ _  _ _ \| ___   (_) _ _  (_)| |_    | | _  _  __ _
  | / /| |/ _` || '_|  (_-/   | || ' \ | ||  _| _ | || || |/ _` |
  |_\_\|_|\__/_||_|    /__/   |_||_||_||_| \__|(_)|_| \_,_|\__,_|

--]]

-- Vim options
require("options")

-- Various utilities and aliases for lua
require("utils")

-- Bootstrap and set up plugins
require("lazy-config")

-- Custom functions
require("functions")

-- Various settings and QOL stuff
require("misc")

-- Markdown config
require("markdown")

-- Plugin settings and config
require("plugins")

-- Colorscheme setup
require("colorscheme")

-- LSP and autocompletion setup
require("lsp")

-- Terminal stuff
require("terminal")

-- Telescope
require("telescope-config")
