-- lazydev: Lua LSP for Neovim config/runtime/plugins
local lazydev = try_require("lazydev")
if lazydev then
    lazydev.setup({
        library = {
            -- Load luvit types when the `vim.uv` word is found
            { path = "luvit-meta/library", words = { "vim%.uv" } },
        },
    })
end

-- fidget: LSP progress notifications
local fidget = try_require("fidget")
if fidget then
    fidget.setup()
end

-- mason: LSP/tool installer
local mason = try_require("mason")
if not mason then
    return
end
mason.setup()

local mason_lspconfig = try_require("mason-lspconfig")
local lspconfig = try_require("lspconfig")
if not mason_lspconfig or not lspconfig then
    return
end

local servers = {
    -- clangd = {},
    -- pyright = {},
    -- rust_analyzer = {},
    gopls   = {},
    ts_ls   = {},
    denols  = {
        root_dir = lspconfig.util.root_pattern("deno.json", "deno.jsonc"),
    },
    html     = { filetypes = { "html", "twig", "hbs", "vue" } },
    emmet_ls = {},
    eslint   = {},
    lua_ls   = {
        settings = {
            Lua = {
                workspace  = { checkThirdParty = false },
                telemetry  = { enable = false },
                diagnostics = { disable = { "missing-fields" } },
            },
        },
    },
}

-- Capabilities: merge LSP defaults with what blink.cmp advertises
local capabilities = vim.tbl_deep_extend(
    "force",
    vim.lsp.protocol.make_client_capabilities(),
    require("blink.cmp").get_lsp_capabilities()
)

-- Ensure servers and tools are installed via mason-tool-installer
local mason_tool_installer = try_require("mason-tool-installer")
if mason_tool_installer then
    local ensure_installed = vim.tbl_keys(servers)
    vim.list_extend(ensure_installed, { "stylua" })
    mason_tool_installer.setup({ ensure_installed = ensure_installed })
end

-- Set up servers via mason-lspconfig handlers
mason_lspconfig.setup({
    handlers = {
        function(server_name)
            local server = servers[server_name] or {}
            server.capabilities = vim.tbl_deep_extend("force", {}, capabilities, server.capabilities or {})
            lspconfig[server_name].setup(server)
        end,
    },
})

-- Per-buffer keymaps and features when an LSP attaches
vim.api.nvim_create_autocmd("LspAttach", {
    group = augroup("lsp_attach"),
    callback = function(ev)
        local map = function(keys, func, desc)
            vim.keymap.set("n", keys, func, { buffer = ev.buf, desc = "LSP: " .. desc })
        end

        local pick = try_require("mini.pick")

        -- stylua: ignore start
        map("gd",         pick and function() pick.builtin.lsp({ scope = "definition" })       end or vim.lsp.buf.definition,      "[G]oto [D]efinition")
        map("gr",         pick and function() pick.builtin.lsp({ scope = "references" })        end or vim.lsp.buf.references,      "[G]oto [R]eferences")
        map("gI",         pick and function() pick.builtin.lsp({ scope = "implementation" })    end or vim.lsp.buf.implementation,  "[G]oto [I]mplementation")
        map("<leader>D",  pick and function() pick.builtin.lsp({ scope = "type_definition" })   end or vim.lsp.buf.type_definition, "Type [D]efinition")
        map("<leader>ds", pick and function() pick.builtin.lsp({ scope = "document_symbol" })   end or vim.lsp.buf.document_symbol, "[D]ocument [S]ymbols")
        map("<leader>ws", pick and function() pick.builtin.lsp({ scope = "workspace_symbol" })  end or vim.lsp.buf.workspace_symbol,"[W]orkspace [S]ymbols")
        map("gD",         vim.lsp.buf.declaration,                                            "[G]oto [D]eclaration")
        map("K",          function() vim.lsp.buf.hover({ border = "rounded" }) end,          "Hover Documentation")
        map("<C-k>",      function() vim.lsp.buf.signature_help({ border = "rounded" }) end, "Signature Help")
        map("<leader>rn", vim.lsp.buf.rename,       "[R]e[n]ame")
        map("<leader>ca", vim.lsp.buf.code_action,  "[C]ode [A]ction")
        -- stylua: ignore end

        local client = vim.lsp.get_client_by_id(ev.data.client_id)

        -- Disable semantic token highlighting (let treesitter handle colours)
        if client then
            client.server_capabilities.semanticTokensProvider = nil
        end

        -- Document highlight: highlight all references of the word under cursor
        if client and client.server_capabilities.documentHighlightProvider then
            local hl_group = augroup("lsp_highlight")
            vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
                buffer = ev.buf,
                group = hl_group,
                callback = vim.lsp.buf.document_highlight,
            })
            vim.api.nvim_create_autocmd({ "CursorMoved", "CursorMovedI" }, {
                buffer = ev.buf,
                group = hl_group,
                callback = vim.lsp.buf.clear_references,
            })
            vim.api.nvim_create_autocmd("LspDetach", {
                group = augroup("lsp_detach"),
                callback = function(ev2)
                    vim.lsp.buf.clear_references()
                    vim.api.nvim_clear_autocmds({ group = "klar_lsp_highlight", buffer = ev2.buf })
                end,
            })
        end

        -- Inlay hints toggle (if the server supports them)
        if client and client.server_capabilities.inlayHintProvider and vim.lsp.inlay_hint then
            map("<leader>th", function()
                vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled())
            end, "[T]oggle Inlay [H]ints")
        end
    end,
})

-- Diagnostic keymaps
-- stylua: ignore starts
vim.keymap.set("n", "[d",         vim.diagnostic.goto_prev,   { desc = "Go to previous diagnostic" })
vim.keymap.set("n", "]d",         vim.diagnostic.goto_next,   { desc = "Go to next diagnostic" })
vim.keymap.set("n", "<leader>e",  vim.diagnostic.open_float,  { desc = "Open floating diagnostic" })
vim.keymap.set("n", "<leader>q",  vim.diagnostic.setloclist,  { desc = "Open diagnostics list" })
-- stylua: ignore end

