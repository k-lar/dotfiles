local pick = try_require("mini.pick")
if not pick then return end

pick.setup({
    mappings = {
        -- <CR> opens in a new tab (mirrors old telescope behaviour)
        -- <S-CR> opens in the current window
        choose            = "<S-CR>",
        choose_in_tabpage = "<CR>",
    },
    window = {
        config = function()
            local width  = math.floor(vim.o.columns * 0.7)
            local height = math.floor(vim.o.lines   * 0.6)
            return {
                anchor = "NW",
                width  = width,
                height = height,
                row    = math.floor((vim.o.lines   - height) / 2),
                col    = math.floor((vim.o.columns - width)  / 2),
            }
        end,
    },
})

-- Smart project files: git ls-files when inside a repo, all files otherwise
local function project_files()
    vim.fn.system("git rev-parse --is-inside-work-tree")
    if vim.v.shell_error == 0 then
        pick.builtin.files({ tool = "git" })
    else
        pick.builtin.files()
    end
end

-- Live grep anchored at the git root when inside a repo
local function grep_from_git_root()
    vim.fn.system("git rev-parse --is-inside-work-tree")
    local opts = nil
    if vim.v.shell_error == 0 then
        local dot_git = vim.fn.finddir(".git", ".;")
        if type(dot_git) == "table" then
            dot_git = dot_git[1] or ""
        end

        if dot_git ~= "" then
            local git_root = vim.fn.fnamemodify(dot_git, ":h")
            opts = { source = { cwd = git_root } }
        end
    end
    pick.builtin.grep_live(nil, opts)
end

-- stylua: ignore start
vim.keymap.set("n", "<leader>ff", project_files,                                                                           { desc = "Search project files" })
vim.keymap.set("n", "<leader>fF", function() pick.builtin.files() end,                                                     { desc = "Search files" })
vim.keymap.set("n", "<leader>fg", grep_from_git_root,                                                                      { desc = "Search git project files" })
vim.keymap.set("n", "<leader>fG", function() pick.builtin.grep({ pattern = vim.fn.expand("<cword>") }) end,                { desc = "Search word under cursor in files" })
vim.keymap.set("n", "<leader>fs", function() pick.builtin.files({ tool = "git" }) end,                                     { desc = "Search git files" })
vim.keymap.set("n", "<leader>fb", function() pick.builtin.buffers() end,                                                   { desc = "Search buffers" })
vim.keymap.set("n", "<leader>fh", function() pick.builtin.help() end,                                                      { desc = "Search help" })
vim.keymap.set("n", "<leader>fn", function() pick.builtin.files(nil, { source = { cwd = vim.fn.stdpath("config") } }) end, { desc = "Search Neovim config files" })
-- stylua: ignore end
