-- Apply retrobox if on newer version than 0.10
if vim.fn.has("nvim-0.10") == 1 and vim.g.custom_colorscheme_loaded == false then
    vim.cmd([[colorscheme retrobox]])

    if vim.g.colors_name == "retrobox" then
        vim.cmd([[
            highlight NonText ctermbg=none guibg=none
            highlight Normal ctermbg=none guibg=#262626
            highlight VertSplit ctermbg=none guibg=none
            highlight NonText ctermbg=none guibg=none
            highlight StatusLine ctermbg=none ctermfg=Grey
            highlight StatusLineNC ctermbg=none ctermfg=DarkGrey
            highlight GitSignsAdd ctermfg=Green guifg=#AFAF87
            highlight GitSignsChange ctermfg=Blue guifg=#87AFAF
            highlight GitSignsDelete ctermfg=Red guifg=#D75F5F
            highlight TabLine ctermfg=none ctermbg=none
            highlight TabLineFill ctermfg=DarkGrey ctermbg=none
            highlight TabLineSel ctermfg=White ctermbg=none
            highlight Visual ctermfg=none ctermbg=Grey guifg=none guibg=#32302F
            highlight ColorColumn ctermbg=Grey guibg=#32302F
            highlight SignColumn ctermbg=none guibg=none
            highlight Folded ctermbg=DarkGrey guibg=#393939 ctermfg=Grey guifg=#D5C4A1
            highlight FoldColumn ctermbg=none guibg=none
        ]])
    end
end
