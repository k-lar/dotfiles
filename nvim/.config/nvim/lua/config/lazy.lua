-- Install Lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
    vim.fn.system({
        "git",
        "clone",
        "--filter=blob:none",
        "https://github.com/folke/lazy.nvim.git",
        "--branch=stable", -- latest stable release
        lazypath,
    })
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
    { import = "plugins.colorscheme" },
    { import = "plugins.treesitter" },
    { import = "plugins.mini-nvim" },
    { import = "plugins.telescope" },
    { import = "plugins.terminal" },
    { import = "plugins.markdown" },
    { import = "plugins.completion" },
    { import = "plugins.git" },
    { import = "plugins.which-key" },
    { import = "plugins.formatting" },
    { import = "plugins.misc" },
    { import = "plugins.harpoon" },
    { import = "plugins.lspconfig" },
    { import = "plugins.copilot" },
}, {})
