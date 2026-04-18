local augroup = function(name)
    return vim.api.nvim_create_augroup("klar_" .. name, { clear = true })
end

vim.api.nvim_create_autocmd("FileType", {
    pattern = "markdown",
    group = augroup("markdown"),
    desc = "Markdown settings, keymaps and abbreviations",
    callback = function()
        -- Larger text width for easier readability
        vim.opt_local.textwidth = 100

        -- Pandoc: compile to PDF
        vim.keymap.set("n", "<F9>", function()
            vim.fn.system("pandoc -s " .. vim.fn.shellescape(vim.fn.expand("%:p")) .. " -o " .. vim.fn.shellescape(vim.fn.expand("%:p:r")) .. ".pdf")
        end, { buffer = true, silent = true, desc = "Compile markdown to PDF" })

        -- Open compiled PDF in Zathura
        vim.keymap.set("n", "<F8>", function()
            vim.fn.system("zathura " .. vim.fn.shellescape(vim.fn.expand("%:p:r")) .. ".pdf &")
        end, { buffer = true, silent = true, desc = "Open PDF in Zathura" })

        -- LaTeX abbreviations (no Lua API for iabbrev)
        vim.cmd("iabbrev <buffer> txtred \\textcolor{red}{}<Left>")
        vim.cmd("iabbrev <buffer> txtblu \\textcolor{blue}{}<Left>")
        vim.cmd("iabbrev <buffer> uline \\underline{}<Left>")

        -- Suppress zero-width word boundary matches in markdown syntax
        vim.cmd([[syn match markdownIgnore "\w\@<=\w\@="]])
    end,
})

-- Markdown fenced languages list (syntax highlighting code inside markdown docs)
vim.g.markdown_fenced_languages = { "python", "html", "c", "vim", "rust", "bash", "sql" }

-- Folding in markdown
vim.keymap.set("n", "<leader>fd", ":set nofoldenable!<CR>", { silent = true })

--- Optional heading text instead of default "Table of contents"
---@param heading_text string | nil
local function create_toc(heading_text)
    heading_text = heading_text or "Table of contents"

    if type(heading_text) ~= "string" then
        error("heading_text must be a string")
    end

    -- Get the current buffer and cursor position
    local buf = vim.api.nvim_get_current_buf()
    local cursor = vim.api.nvim_win_get_cursor(0)

    -- Get all lines in the buffer
    local lines = vim.api.nvim_buf_get_lines(buf, 0, -1, false)

    -- Pattern to match Markdown headings
    local heading_pattern = "^(#+)%s+(.*)"

    -- Table to store the TOC entries
    local toc_heading = "# " .. heading_text
    local toc = { toc_heading, "" }

    -- Iterate over each line to find headings
    for _, line in ipairs(lines) do
        local level, heading = line:match(heading_pattern)
        if level and heading then
            -- Calculate the heading level
            local level_count = #level
            -- Generate the anchor link and sanitize it
            local anchor = heading
                :lower()
                :gsub("%s+", "-")
                :gsub("[%(%)%[%]{}\\/]", "")
                :gsub("Č", "č")
                :gsub("Ž", "ž")
                :gsub("Š", "š")
                :gsub("%-+", "-")

            -- Add the TOC entry
            table.insert(toc, string.rep("    ", level_count - 1) .. string.format("- [%s](#%s)", heading, anchor))
        end
    end

    -- Insert the TOC at the cursor position
    if #toc > 0 then
        vim.api.nvim_buf_set_lines(buf, cursor[1] - 1, cursor[1] - 1, false, toc)
    else
        print("No headings found in the document.")
    end

    -- Restore the original cursor position
    vim.api.nvim_win_set_cursor(0, cursor)
end

local utils = require("core.utils")
vim.api.nvim_create_user_command("GenerateTOC", function(opts)
    -- Check if an argument is provided; use it or default to nil
    local heading_text = opts.args ~= "" and utils.trim_quotes(opts.args) or nil
    create_toc(heading_text)
end, { nargs = "?" })
