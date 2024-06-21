require("core.utils")

-- Pandoc markdown -> pdf compilation
vim.cmd([[
    augroup my_markdown
        autocmd!
        autocmd FileType markdown nnoremap <silent><F9> :<c-u>call system('pandoc -s '.expand('%:p:S').' -o '.expand('%:p:r:S').'.pdf')<cr>
        autocmd FileType markdown nnoremap <silent><F8> :<c-u>call system('zathura '.expand('%:p:r:S').'.pdf &')<cr>
    augroup END
]])

-- Markdown syntax and configuration
vim.cmd([[au BufNewFile,BufFilePre,BufRead *.md set filetype=markdown]])
vim.cmd([[au BufNewFile,BufRead,BufWrite *.md syntax match Comment /\%^---\_.\{-}---$/]])
vim.cmd([[au filetype markdown :iabbrev txtred \textcolor{red}{}<Left>]])
vim.cmd([[au filetype markdown :iabbrev txtblu \textcolor{blue}{}<Left>]])
vim.cmd([[au filetype markdown :iabbrev uline \underline{}<Left>]])
vim.cmd([[au BufNewFile,BufRead,BufEnter *.md syn match markdownIgnore "\w\@<=\w\@="]])

-- Larger text width in terminal for easier readability (In markdown files)
vim.cmd("au FileType markdown setlocal textwidth=100")

-- Markdown fenced languages list (syntax highlighting code inside markdown docs)
g.markdown_fenced_languages = { "python", "html", "c", "vim", "rust", "bash", "sql" }

-- Folding in markdown
map("<leader>fd")(":set nofoldenable!<CR>")({ silent = true })

local function create_toc()
    -- Get the current buffer and cursor position
    local buf = vim.api.nvim_get_current_buf()
    local cursor = vim.api.nvim_win_get_cursor(0)

    -- Get all lines in the buffer
    local lines = vim.api.nvim_buf_get_lines(buf, 0, -1, false)

    -- Pattern to match Markdown headings
    local heading_pattern = "^(#+)%s+(.*)"

    -- Table to store the TOC entries
    local toc = { "# Table of contents", "" }

    -- Iterate over each line to find headings
    for _, line in ipairs(lines) do
        local level, heading = line:match(heading_pattern)
        if level and heading then
            -- Calculate the heading level
            local level_count = #level
            -- Generate the anchor link (lowercase and replace spaces with dashes)
            -- Also remove slashes from links
            local anchor = heading:lower():gsub("%s+", "-"):gsub("/", ""):gsub("%-+", "-")

            -- Add the TOC entry
            table.insert(toc, string.rep("    ", level_count - 1) .. string.format("- [%s](#%s)", heading, anchor))
        end
    end

    -- Insert the TOC at the cursor position
    if #toc > 0 then
        vim.api.nvim_buf_set_lines(buf, cursor[1] - 1, cursor[1] - 1, false, toc)
        -- Add an empty line after the TOC for better readability
        vim.api.nvim_buf_set_lines(buf, cursor[1] - 1 + #toc, cursor[1] - 1 + #toc, false, { "" })
    else
        print("No headings found in the document.")
    end
end

vim.api.nvim_create_user_command("GenerateTOC", create_toc, {})
