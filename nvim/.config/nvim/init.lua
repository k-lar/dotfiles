--[[
   _    _           ( )        _        _  _       _
  | |__| | __ _  _ _ \| ___   (_) _ _  (_)| |_    | | _  _  __ _
  | / /| |/ _` || '_|  (_-/   | || ' \ | ||  _| _ | || || |/ _` |
  |_\_\|_|\__/_||_|    /__/   |_||_||_||_| \__|(_)|_| \_,_|\__,_|

--]]

-- Core configs that should always work, even if plugins are not working
require("core.utils")
require("core.options")
require("core.keymaps")
require("core.colorscheme")
require("core.autocmds")
require("core.markdown")
require("core.pack")

-- Plugins
require("plugins.mini")
require("plugins.pick")
require("plugins.gitsigns")
require("plugins.dynomark")
require("plugins.treesitter")
require("plugins.which-key")
require("plugins.blink")
require("plugins.misc")
require("plugins.lspconfig")
require("plugins.lualine")
require("plugins.toggleterm")
