require("utils")

-- Colors
o.background = 'dark'
o.termguicolors = true

g.gruvbox_pale_style = "dark-pale"
g.gruvbox_italic_comments = false
g.gruvbox_italic_keywords = false
g.gruvbox_bold_functions = true

vim.cmd("colorscheme gruvbox-pale")

-- Lualine setup
require('lualine').setup {
    options = {
        theme  = "gruvbox-dark-pale",
        section_separators = '',
        component_separators = ''
    },
}

