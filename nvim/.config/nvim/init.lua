--[[
   _    _           ( )        _        _  _       _
  | |__| | __ _  _ _ \| ___   (_) _ _  (_)| |_    | | _  _  __ _
  | / /| |/ _` || '_|  (_-/   | || ' \ | ||  _| _ | || || |/ _` |
  |_\_\|_|\__/_||_|    /__/   |_||_||_||_| \__|(_)|_| \_,_|\__,_|

--]]

-- Various utilities and aliases for lua
require("core.utils")

-- Vim options
require("core.options")

-- Keymaps (core)
require("core.keymaps")

-- Misc - Autocommands (core)
require("core.misc")

-- Markdown config
require("core.markdown")

-- Bootstrap and set up plugins
require("config.lazy")

-- LSP and autocompletion setup
require("config.lsp")
