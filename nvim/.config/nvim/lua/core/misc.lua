require("core.utils")

-- Highlight on yank
local group = vim.api.nvim_create_augroup("user_cmds", { clear = true })

vim.api.nvim_create_autocmd("TextYankPost", {
    desc = "Highlight on yank",
    group = group,
    callback = function() vim.highlight.on_yank({ higroup = "Visual", timeout = 200 }) end,
})

-- Quick exit from help docs
vim.api.nvim_create_autocmd("FileType", {
    pattern = { "help", "man", "checkhealth" },
    group = group,
    command = "nnoremap <buffer> q <cmd>quit<cr>",
})

-- Show color column at 80 characters if cursor position is more than 70
vim.api.nvim_create_autocmd({ "CursorMoved", "CursorMovedI" }, {
    pattern = "*",
    callback = function()
        local col = vim.fn.virtcol(".")
        if col > 70 and col < 82 then
            o.colorcolumn = "80"
        elseif col > 110 then
            o.colorcolumn = "120"
        else
            o.colorcolumn = ""
        end
    end,
})

-- Automatically deletes all trailing whitespaces on save (except .md files)
function StripTrailingWhiteSpace()
    -- don't strip on these filetypes
    if vim.bo.filetype == "markdown" then return end
    vim.api.nvim_command("%s/\\s\\+$//e")
end
vim.cmd([[autocmd BufWritePre * lua StripTrailingWhiteSpace()]])

function ToggleNetrw()
    if vim.g.NetrwIsOpen then
        local i = vim.fn.bufnr("$")
        while i >= 1 do
            if vim.fn.getbufvar(i, "&filetype") == "netrw" then vim.cmd("silent bwipeout " .. i) end
            i = i - 1
        end
        vim.g.NetrwIsOpen = false
    else
        vim.g.NetrwIsOpen = true
        vim.cmd("silent Lexplore .")
    end
end

vim.api.nvim_create_autocmd("filetype", {
    pattern = "netrw",
    desc = "Better mappings for netrw",
    callback = function()
        local bind = function(lhs, rhs) vim.keymap.set("n", lhs, rhs, { remap = true, buffer = true }) end
        bind("n", "%") -- edit new file
        bind("r", "R") -- rename file
    end,
})

-- Mouse toggle (useful for copying and pasting where vim is not compiled with +clipboard)
function ToggleMouse()
    if vim.o.mouse == "a" then
        vim.o.mouse = ""
        print("Mouse disabled")
    else
        vim.o.mouse = "a"
        print("Mouse enabled")
    end
end

-- Compile script
function BuildScript()
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

    if found == false then print("Could not find any build script or file.") end
end
