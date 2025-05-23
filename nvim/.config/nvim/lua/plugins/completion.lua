return {
    { -- Autocompletion
        "hrsh7th/nvim-cmp",
        event = "InsertEnter",
        dependencies = {
            -- Snippet Engine & its associated nvim-cmp source
            {
                "L3MON4D3/LuaSnip",
                config = function()
                    local luasnip = require("luasnip")
                    local types = require("luasnip.util.types")

                    require("luasnip.loaders.from_vscode").lazy_load()

                    -- HACK: Cancel the snippet session when leaving insert mode.
                    vim.api.nvim_create_autocmd("ModeChanged", {
                        group = vim.api.nvim_create_augroup("UnlinkSnippetOnModeChange", { clear = true }),
                        pattern = { "s:n", "i:*" },
                        callback = function(event)
                            if
                                luasnip.session
                                and luasnip.session.current_nodes[event.buf]
                                and not luasnip.session.jump_active
                            then
                                luasnip.unlink_current()
                            end
                        end,
                    })

                    luasnip.setup({
                        -- Display a cursor-like placeholder in unvisited nodes
                        -- of the snippet.
                        ext_opts = {
                            [types.insertNode] = {
                                unvisited = {
                                    virt_text = { { "|", "Conceal" } },
                                    virt_text_pos = "inline",
                                },
                            },
                            [types.exitNode] = {
                                unvisited = {
                                    virt_text = { { "|", "Conceal" } },
                                    virt_text_pos = "inline",
                                },
                            },
                        },
                    })
                end,
            },
            "saadparwaiz1/cmp_luasnip",

            -- Adds LSP completion capabilities
            "hrsh7th/cmp-nvim-lsp",

            -- Adds local buffer symbol completion
            "hrsh7th/cmp-buffer",

            -- Adds emoji completion
            "hrsh7th/cmp-emoji",

            -- Adds path completion
            "hrsh7th/cmp-path",

            -- Adds a number of user-friendly snippets
            "rafamadriz/friendly-snippets",
        },
        config = function()
            local cmp = require("cmp")
            local luasnip = require("luasnip")
            require("luasnip").filetype_extend("vue", { "html", "emmet_ls" })
            require("luasnip.loaders.from_vscode").lazy_load()
            luasnip.config.setup({})

            vim.g.cmptoggle = true -- Init global variable to true -> nvim-cmp on by default

            cmp.setup({
                enabled = function()
                    return vim.g.cmptoggle
                end,

                snippet = {
                    expand = function(args)
                        luasnip.lsp_expand(args.body)
                    end,
                },
                completion = {
                    completeopt = "menu,menuone,noinsert",
                },
                mapping = cmp.mapping.preset.insert({
                    ["<C-n>"] = cmp.mapping.select_next_item(),
                    ["<C-p>"] = cmp.mapping.select_prev_item(),
                    ["<C-d>"] = cmp.mapping.scroll_docs(-4),
                    ["<C-f>"] = cmp.mapping.scroll_docs(4),
                    ["<C-Space>"] = cmp.mapping.complete({}),
                    ["<S-CR>"] = cmp.mapping.confirm({
                        behavior = cmp.ConfirmBehavior.Replace,
                        select = true,
                    }),
                    ["<Tab>"] = cmp.mapping(function(fallback)
                        if cmp.visible() then
                            cmp.select_next_item()
                        elseif luasnip.locally_jumpable(1) then
                            luasnip.jump(1)
                        else
                            fallback()
                        end
                    end, { "i", "s" }),
                    ["<S-Tab>"] = cmp.mapping(function(fallback)
                        if cmp.visible() then
                            cmp.select_prev_item()
                        elseif luasnip.locally_jumpable(-1) then
                            luasnip.jump(-1)
                        else
                            fallback()
                        end
                    end, { "i", "s" }),
                }),
                sources = {
                    {
                        name = "lazydev",
                        -- set group index to 0 to skip loading LuaLS completions as lazydev recommends it
                        group_index = 0,
                    },
                    { name = "nvim_lsp" },
                    { name = "luasnip" },
                    { name = "buffer" },
                    { name = "emoji" },
                    { name = "path" },
                },
                window = {
                    documentation = cmp.config.window.bordered(),
                },
            })
        end,
    },
}
