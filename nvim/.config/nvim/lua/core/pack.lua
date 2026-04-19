if not vim.pack then
    return
end

-- Build hooks must be registered before vim.pack.add()
vim.api.nvim_create_autocmd("PackChanged", {
    callback = function(ev)
        local name, kind = ev.data.spec.name, ev.data.kind
        if name == "nvim-treesitter" and (kind == "install" or kind == "update") then
            vim.schedule(function() vim.cmd("TSUpdate") end)
        end
    end,
})

vim.pack.add({
    { src = "https://github.com/echasnovski/mini.pick" },
    { src = "https://github.com/echasnovski/mini.move" },
    { src = "https://github.com/echasnovski/mini.comment" },
    { src = "https://github.com/echasnovski/mini.indentscope" },
    { src = "https://github.com/echasnovski/mini.surround" },
    { src = "https://github.com/echasnovski/mini.icons" },
    { src = "https://github.com/lewis6991/gitsigns.nvim" },
    { src = "https://github.com/github/copilot.vim" },
    { src = "https://github.com/dhruvasagar/vim-table-mode" },
    { src = "https://github.com/dkarter/bullets.vim" },
    { src = "https://github.com/k-lar/dynomark.nvim" },
    { src = "https://github.com/nvim-treesitter/nvim-treesitter" },
    { src = "https://github.com/folke/which-key.nvim" },
    { src = "https://github.com/saghen/blink.cmp", version = "v1" },
    { src = "https://github.com/moyiz/blink-emoji.nvim" },
    { src = "https://github.com/danymat/neogen" },
    { src = "https://github.com/folke/flash.nvim" },
    { src = "https://github.com/folke/todo-comments.nvim" },
    { src = "https://github.com/brenoprata10/nvim-highlight-colors" },
    { src = "https://github.com/neovim/nvim-lspconfig" },
    { src = "https://github.com/williamboman/mason.nvim" },
    { src = "https://github.com/williamboman/mason-lspconfig.nvim" },
    { src = "https://github.com/WhoIsSethDaniel/mason-tool-installer.nvim" },
    { src = "https://github.com/j-hui/fidget.nvim" },
    { src = "https://github.com/folke/lazydev.nvim" },
    { src = "https://github.com/Bilal2453/luvit-meta" },
    { src = "https://github.com/k-lar/dark-pale-gruvbox-lualine.nvim" },
    { src = "https://github.com/nvim-lualine/lualine.nvim" },
    { src = "https://github.com/akinsho/toggleterm.nvim" },
    { src = "https://github.com/mluders/comfy-line-numbers.nvim" },
})
