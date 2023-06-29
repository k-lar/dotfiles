require("utils")

-- Pandoc markdown -> pdf compilation
vim.cmd[[
    augroup my_markdown
        autocmd!
        autocmd FileType markdown nnoremap <silent><F9> :<c-u>call system('pandoc -s '.expand('%:p:S').' -o '.expand('%:p:r:S').'.pdf')<cr>
        autocmd FileType markdown nnoremap <silent><F8> :<c-u>call system('zathura '.expand('%:p:r:S').'.pdf &')<cr>
    augroup END
]]

-- Markdown syntax and configuration
vim.cmd[[au BufNewFile,BufFilePre,BufRead *.md set filetype=markdown]]
vim.cmd[[au BufNewFile,BufRead,BufWrite *.md syntax match Comment /\%^---\_.\{-}---$/]]
vim.cmd[[au filetype markdown :iabbrev txtred \textcolor{red}{}<Left>]]
vim.cmd[[au filetype markdown :iabbrev txtblu \textcolor{blue}{}<Left>]]
vim.cmd[[au filetype markdown :iabbrev uline \underline{}<Left>]]
vim.cmd[[au BufNewFile,BufRead,BufEnter *.md syn match markdownIgnore "\w\@<=\w\@="]]

-- Larger text width in terminal for easier readability (In markdown files)
vim.cmd("au FileType markdown setlocal textwidth=100")

-- Markdown fenced languages list (syntax highlighting code inside markdown docs)
g.markdown_fenced_languages = {'python', 'html', 'c', 'vim', 'rust', 'bash', 'sql'}

-- Folding in markdown
g.markdown_folding = 1
map '<leader>fd' ':set nofoldenable!<CR>' {silent = true}

