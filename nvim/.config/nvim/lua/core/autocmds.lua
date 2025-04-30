local function augroup(name)
    return vim.api.nvim_create_augroup("klar_" .. name, { clear = true })
end

vim.api.nvim_create_autocmd("TextYankPost", {
    desc = "Highlight on yank",
    group = augroup("highlight_on_yank"),
    callback = function()
        vim.highlight.on_yank({ higroup = "Visual", timeout = 200 })
    end,
})

vim.api.nvim_create_autocmd("FileType", {
    pattern = {
        "help",
        "man",
        "checkhealth",
        "qf",
        "notify",
        "nofile",
        "lspinfo",
        "terminal",
        "prompt",
        "toggleterm",
        "copilot",
        "startuptime",
        "tsplayground",
        "PlenaryTestPopup",
    },
    desc = "Quick exit from certain buffer types",
    group = augroup("quick_exit"),
    command = "nnoremap <buffer> q <cmd>close<cr>",
})

vim.api.nvim_create_autocmd("FileType", {
    pattern = "qf",
    desc = "Ignore mapping of flash.nvim in qf buffers so you can go to errors with <CR>",
    group = augroup("qf_enter_keybind"),
    command = "nnoremap <buffer> <CR> <CR>",
})

vim.api.nvim_create_autocmd({ "CursorMoved", "CursorMovedI" }, {
    pattern = "*",
    desc = "Show color column at 80 characters if cursor position is more than 70",
    group = augroup("dynamic_color_column"),
    callback = function()
        local col = vim.fn.virtcol(".")
        if col > 70 and col < 82 then
            vim.opt.colorcolumn = "80"
        elseif col > 110 then
            vim.opt.colorcolumn = "120"
        else
            vim.opt.colorcolumn = ""
        end
    end,
})

vim.api.nvim_create_autocmd({ "FocusGained", "TermClose", "TermLeave" }, {
    desc = "Reload the file when changes are detected",
    group = augroup("checktime"),
    callback = function()
        if vim.o.buftype ~= "nofile" then
            vim.cmd("checktime")
        end
    end,
})

vim.api.nvim_create_autocmd("BufWritePre", {
    pattern = "*",
    desc = "Delete all trailing whitespaces on save (except .md files)",
    group = augroup("delete_trailing_whitespace"),
    callback = function()
        if vim.bo.filetype == "markdown" then
            return
        end
        vim.api.nvim_command("%s/\\s\\+$//e")
    end,
})

vim.api.nvim_create_autocmd("FileType", {
    pattern = "netrw",
    desc = "Better mappings for netrw",
    group = augroup("better_netrw_keymaps"),
    callback = function()
        local bind = function(lhs, rhs)
            vim.keymap.set("n", lhs, rhs, { remap = true, buffer = true })
        end
        bind("n", "%") -- edit new file
        bind("r", "R") -- rename file
    end,
})

vim.api.nvim_create_autocmd("FileType", {
    pattern = "*",
    desc = "Toggle netrw with <leader>n",
    group = augroup("toggle_netrw"),
    callback = function()
        local function toggleNetrw()
            if vim.g.NetrwIsOpen then
                local i = vim.fn.bufnr("$")
                while i >= 1 do
                    if vim.fn.getbufvar(i, "&filetype") == "netrw" then
                        vim.cmd("silent bwipeout " .. i)
                    end
                    i = i - 1
                end
                vim.g.NetrwIsOpen = false
            else
                vim.g.NetrwIsOpen = true
                vim.cmd("silent Lexplore .")
            end
        end

        vim.keymap.set({ "n", "v" }, "<leader>n", function()
            toggleNetrw()
        end, { desc = "Toggle netrw" })
    end,
})

vim.api.nvim_create_autocmd("FileType", {
    pattern = "*",
    desc = "Toggle mouse with <leader>M",
    group = augroup("toggle_mouse"),
    callback = function()
        local function toggleMouse()
            if vim.o.mouse == "a" then
                vim.o.mouse = ""
                print("Mouse disabled")
            else
                vim.o.mouse = "a"
                print("Mouse enabled")
            end
        end

        vim.keymap.set({ "n", "v" }, "<leader>M", function()
            toggleMouse()
        end, { desc = "Toggle mouse" })
    end,
})

vim.api.nvim_create_autocmd("FileType", {
    pattern = "*",
    desc = "Try building project with <leader>b",
    group = augroup("buildscript"),
    callback = function()
        local function buildScript()
            local filenames = { "Makefile", "build.sh", "compile.sh" }
            local found = false
            for fileCount = 1, #filenames do
                local file = vim.fn.findfile(filenames[fileCount], ".;")
                if filenames[fileCount] == "Makefile" and file ~= "" then
                    vim.cmd(":term " .. "make")
                    found = true
                    break
                elseif filenames[fileCount] == "build.sh" and file ~= "" then
                    vim.cmd(":term ./" .. file)
                    found = true
                    break
                elseif filenames[fileCount] == "compile.sh" and file ~= "" then
                    vim.cmd(":term ./" .. file)
                    found = true
                    break
                end
            end

            if found == false then
                print("Could not find any build script or file.")
            end
        end

        vim.keymap.set({ "n", "v" }, "<leader>b", function()
            buildScript()
        end, { desc = "Run build.sh in project root" })
    end,
})

vim.api.nvim_create_autocmd("BufEnter", {
    desc = "Fallback for moving lines up/down",
    group = augroup("fallback_move_lines"),
    -- stylua: ignore
    callback = function()
        if not vim.g.mini_move_loaded then
            vim.keymap.set("i", "<C-Down>", "<Esc>:m .+1<CR>==gi", { desc = "Move the line down", silent = true })
            vim.keymap.set("i", "<C-Up>", "<Esc>:m .-2<CR>==gi", { desc = "Move the line up", silent = true })
            vim.keymap.set("n", "<C-Down>", "<cmd>m+<CR>==", { desc = "Move the line down", silent = true })
            vim.keymap.set("n", "<C-Up>", "<cmd>m-2<CR>==", { desc = "Move the line up", silent = true })
            vim.keymap.set("v", "<C-Up>", ":m '<-2<CR>gv=gv", { desc = "Move the selected text up", noremap = true, silent = true })
            vim.keymap.set("v", "<C-Down>",":m '>+1<CR>gv=gv",{ desc = "Move the selected text down", noremap = true, silent = true })
            vim.keymap.set("n", "<C-Right>", "<Cmd>>><CR>", { desc = "Indent the line", silent = true })
            vim.keymap.set("n", "<C-Left>", "<Cmd><<<CR>", { desc = "Dedent the line", silent = true })
            vim.keymap.set("i", "<C-Right>", "<Esc>:>><CR>i", { desc = "Indent the line", silent = true })
            vim.keymap.set("i", "<C-Left>", "<Esc>:<<<CR>i", { desc = "Dedent the line", silent = true })
        end
    end,
})

vim.api.nvim_create_autocmd({ "CursorMoved", "CursorMovedI" }, {
    callback = function()
        vim.defer_fn(function()
            vim.diagnostic.open_float(nil, { focusable = false })
        end, 1000)
    end,
})
