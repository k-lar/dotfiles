local lualine = try_require("lualine")
if not lualine then return end

lualine.setup({
    options = {
        theme                = "gruvbox-dark-pale",
        section_separators   = "",
        component_separators = "",
    },
})
