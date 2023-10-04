require("utils")

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

-- Define the custom_compile() function
function custom_compile()
    -- Get the directory of the current file
    local current_file = vim.fn.expand("%:p")
    local current_directory = vim.fn.fnamemodify(current_file, ":h")

    -- Function to execute a command and capture the output
    local function execute_command(command)
        local command_output = vim.fn.systemlist(command, current_directory)
        if #command_output > 0 then
            vim.fn.setqflist({}, " ", {
                title = "Compile Output",
                lines = command_output,
            })
            vim.cmd("copen")
        else
            print("No output to display.")
        end
    end

    -- Check if Makefile exists in the current directory
    local makefile_path = current_directory .. "/Makefile"
    local makefile_exists = vim.fn.filereadable(makefile_path) == 1

    -- Check if build.sh exists in the current directory
    local build_script_path = current_directory .. "/build.sh"
    local build_script_exists = vim.fn.filereadable(build_script_path) == 1

    if makefile_exists then
        execute_command("make")
        print("Running Makefile...")
    elseif build_script_exists then
        execute_command("sh build.sh")
        print("Running build.sh...")
    else
        -- Check if the current file is within a Git repository
        local git_root = vim.fn.systemlist("git rev-parse --show-toplevel", current_directory)
        if #git_root > 0 then
            git_root = git_root[1]
            local git_makefile_path = git_root .. "/Makefile"
            local git_build_script_path = git_root .. "/build.sh"

            if vim.fn.filereadable(git_makefile_path) == 1 then
                execute_command("make -C " .. git_root)
                print("Running Makefile from Git root...")
            elseif vim.fn.filereadable(git_build_script_path) == 1 then
                execute_command("sh " .. git_build_script_path)
                print("Running build.sh from Git root...")
            else
                print("No Makefile or build.sh found in Git root.")
            end
        else
            print("No Makefile or build.sh found.")
        end
    end
end

-- Create the :Compile command
vim.cmd([[command! -nargs=0 Compile lua custom_compile()]])
