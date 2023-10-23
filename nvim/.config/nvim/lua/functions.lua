require("utils")
local wk = require("which-key")

-- Automatically deletes all trailing whitespaces on save (except .md files)
function StripTrailingWhiteSpace()
    -- don't strip on these filetypes
    if vim.bo.filetype == "markdown" then
        return
    end
    vim.api.nvim_command("%s/\\s\\+$//e")
end
vim.api.nvim_command("autocmd BufWritePre * lua StripTrailingWhiteSpace()")

-- Netrw config
g.netrw_liststyle = 3
g.netrw_banner = 0
g.netrw_browse_split = 4
g.netrw_winsize = 25
g.NetrwIsOpen = false

function ToggleNetrw()
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

nmap("<leader>n")(":lua ToggleNetrw()<CR>")({ silent = true }) -- Toggle netrw with SPC-n

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

nnoremap("<leader>M")(":lua ToggleMouse()<CR>")

-- Very simple TODO management
function Todo()
    vim.cmd("silent noautocmd vimgrep /\\CTODO\\+:\\|\\CFIXME\\+:/g %")
    vim.cmd("vert cwindow")
    vim.cmd("winc =")
end

function CheckTodo()
    if pcall(Todo()) then
        -- no errors while running `foo'
        Todo()
    else
        -- `foo' raised an error: take appropriate actions
        print("No TODOs found.")
    end
end
vim.cmd("command! Todo :silent! lua CheckTodo()")

inoremap("<F4>")("<ESC>:Todo<cr>")
nnoremap("<F4>")(":Todo<cr>")
inoremap("<F3>")("<ESC>:cclose<cr>")
nnoremap("<F3>")(":cclose<cr>")

-- Compile script
local function build_script()
    filenames = { "Makefile", "build.sh", "compile.sh" }
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

wk.register({
    ["<leader>b"] = { function() build_script() end, "Run build.sh in project root" },
})

vim.cmd([[:tnoremap <Esc> <C-\><C-n>]])
