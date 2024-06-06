return {
    {
        "nvim-telescope/telescope.nvim",
        branch = "0.1.x",
        dependencies = {
            "nvim-lua/plenary.nvim",
            {
                "nvim-telescope/telescope-fzf-native.nvim",
                build = "make",
                cond = function() return vim.fn.executable("make") == 1 end,
            },
        },
        config = function()
            local actions = require("telescope.actions")
            require("telescope").setup({
                defaults = {
                    sorting_strategy = "ascending",
                    layout_config = {
                        horizontal = {
                            width = 0.7,
                            prompt_position = "top",
                            preview_width = 0.65,
                            preview_cutoff = 80,
                        },
                        vertical = {
                            width = 0.5,
                            prompt_position = "top",
                            preview_width = 0.6,
                        },
                    },
                    mappings = {
                        i = {
                            ["<esc>"] = actions.close,
                            ["<CR>"] = actions.select_tab,
                            ["<S-CR>"] = actions.select_default,
                        },
                    },
                },
            })

            -- Enable telescope fzf native, if installed
            pcall(require("telescope").load_extension, "fzf")

            local is_inside_work_tree = {}

            Telescope_project_files = function()
                local opts = {} -- define here if you want to define something

                local cwd = vim.fn.getcwd()
                if is_inside_work_tree[cwd] == nil then
                    vim.fn.system("git rev-parse --is-inside-work-tree")
                    is_inside_work_tree[cwd] = vim.v.shell_error == 0
                end

                if is_inside_work_tree[cwd] then
                    require("telescope.builtin").git_files(opts)
                else
                    require("telescope.builtin").find_files(opts)
                end
            end

            function Telescope_live_grep_from_project_git_root()
                local function is_git_repo()
                    vim.fn.system("git rev-parse --is-inside-work-tree")

                    return vim.v.shell_error == 0
                end

                local function get_git_root()
                    local dot_git_path = vim.fn.finddir(".git", ".;")
                    return vim.fn.fnamemodify(dot_git_path, ":h")
                end

                local opts = {}

                if is_git_repo() then opts = {
                    cwd = get_git_root(),
                } end

                require("telescope.builtin").live_grep(opts)
            end
        end,
        -- stylua: ignore
        keys = {
            { "<leader>ff", function() Telescope_project_files() end, desc = "Search project files" },
            { "<leader>fF", function() require("telescope.builtin").find_files() end, desc = "Search files" },
            { "<leader>fg", function() Telescope_live_grep_from_project_git_root() end, desc = "Search git project files" },
            { "<leader>fG", function() require('telescope.builtin').grep_string() end, desc = "Search for string in files" },
            { "<leader>fs", function() require('telescope.builtin').git_files() end, desc = "Search git files" },
            { "<leader>fb", function() require('telescope.builtin').buffers() end, desc = "Search buffers" },
            { "<leader>fh", function() require('telescope.builtin').help_tags() end, desc = "Search help" },
        },
    },
}
