"  _    _            ( )               _
" | |__| | __ _  _ _  \| ___     __ __(_) _ __   _ _  __
" | / /| |/ _` || '_|   (_-/     \ V /| || '  \ | '_|/ _|
" |_\_\|_|\__/_||_|     /__/      \_/ |_||_|_|_||_|  \__|
"

let mapleader =" "

" My plugins
call plug#begin('~/.vim/plugged')
Plug 'junegunn/goyo.vim'
Plug 'tpope/vim-fugitive'
Plug 'morhetz/gruvbox'
Plug 'fladson/vim-kitty'
Plug 'ernstwi/vim-secret'
Plug 'itchyny/lightline.vim'
Plug 'shinchu/lightline-gruvbox.vim'
Plug 'dkarter/bullets.vim'
Plug 'ojroques/vim-scrollstatus'
Plug 'rinx/nvim-minimap'
Plug 'vimwiki/vimwiki'

" Coding plugins
Plug 'ackyshake/VimCompletesMe'
Plug 'mattn/emmet-vim'
Plug 'rust-lang/rust.vim'
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'} "Update parser on update
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim'

call plug#end()

" Some basics:
	syntax on
	filetype plugin on
	set encoding=utf-8
	set number relativenumber
	set clipboard=unnamedplus
	set noshowmode " Don't show INSERT mode (for use with lightline)
	set ignorecase
	set smartcase
	set smarttab
	set scrolloff=1
	set sidescrolloff=3
	set mouse=a
	set path+=**

" Abbreviations / aliases
	iabbrev ip IP
	iabbrev ipv6 IPv6
	iabbrev ipv4 IPv4
	iabbrev dhcp DHCP

" Colorscheme config (gruvbox)
	colorscheme gruvbox
	set background=dark

" Lightline colorscheme configuration
	let g:lightline = {
		\ 'colorscheme': 'gruvbox',
		\ 'active': {
		\   'right': [['lineinfo'], ['percent'], ['fileformat', 'fileencoding', 'filetype', 'charvaluehex']]
		\ },
		\ 'component_function': {'percent': 'ScrollStatus'},
		\ }

	let g:scrollstatus_size = 12

" nvim-minimap configuratio nvim-minimap configuration
	nnoremap <leader>m :MinimapToggle <cr>

	let g:minimap#window#width = 20
	let g:minimap#window#height = 20

" Stop vimwiki from taking over markdown files outside wiki directories
	let g:vimwiki_global_ext = 0

" Remap ESC => CapsLock in vim only / 'silent:' prevents confirmation prompt:
" '1>/dev/null 2>&1 &' sends xmodmap warning on Shift+ZZ/ZQ to /dev/null
	au VimEnter * silent: !xmodmap -e 'clear Lock' -e 'keycode 0x42 = Escape' 1>/dev/null 2>&1 &
	au VimLeave * silent: !xmodmap -e 'clear Lock' -e 'keycode 0x42 = Caps_Lock' 1>/dev/null 2>&1 &

" Markdown syntaxing and QOL features:
" Front of file (title, author, layout...) color change
	au BufNewFile,BufFilePre,BufRead *.md set filetype=markdown
	au BufNewFile,BufRead,BufWrite *.md syntax match Comment /\%^---\_.\{-}---$/
	au filetype markdown :iabbrev txtred \textcolor{red}{}<Left>

" Larger text width in terminal for easier readability (In markdown files)
	au FileType markdown setlocal textwidth=100
	au FileType vimwiki setlocal textwidth=100

" Markdown fenced languages list (syntax highlighting code inside markdown docs)
	let g:markdown_fenced_languages = ['python', 'html', 'c', 'vim', 'rust', 'bash', 'sql']

" Vim autocompletion config (omnifunc)
	set wildmode=longest,list,full
	set wildignore=*.pdf,*.jpg,*.png,*.docx
	set omnifunc=syntaxcomplete#Complete

" Python specific config
	au FileType python setl ofu=pythoncomplete#CompletePython
	augroup PythonLinting
		autocmd!
		" Treat all .py files as python
		autocmd BufNewFile,BufRead *.py set filetype=python
		" Linting Python, the vanilla way
		autocmd FileType python setlocal makeprg=pylint
	augroup END

" Disables automatic commenting on new line
	autocmd FileType * setlocal formatoptions-=c formatoptions-=r formatoptions-=o

" Automatically deletes all trailing whitespaces on save (except .md files)
	fun! StripTrailingWhiteSpace()
  	" don't strip on these filetypes
  	if &ft =~ 'markdown'
    	return
  	endif
  	%s/\s\+$//e
	endfun
	autocmd BufWritePre * :call StripTrailingWhiteSpace()

" Goyo plugin for centering text / better readability
	map <silent> <leader>g :Goyo \| set linebreak<CR>

" Spell checking in English
	map <leader>e :setlocal spell! spelllang=en_us<CR>

" Spell checking in Slovene
	map <silent> <leader>s :setlocal spell! spelllang=sl_si<CR><CR>

" Splits open at the bottom and right, which is non-retarded, unlike vim defaults.
	set splitbelow splitright

" Enable mouse support in vim
	set mouse=a

" Enable closing brackets in vim
	inoremap ( ()<left>
	inoremap [ []<left>

" Netrw config (vim's native file manager)
	let g:netrw_liststyle = 3
	let g:netrw_banner = 0
	let g:netrw_browse_split = 4
	let g:netrw_winsize = 25

" Netrw toggle function
	let g:NetrwIsOpen=0

	function! ToggleNetrw()
    	if g:NetrwIsOpen
        	let i = bufnr("$")
        	while (i >= 1)
            		if (getbufvar(i, "&filetype") == "netrw")
                		silent exe "bwipeout " . i
            		endif
            		let i-=1
        	endwhile
        let g:NetrwIsOpen=0
    	else
        let g:NetrwIsOpen=1
        silent Lexplore .
    	endif
	endfunction

" Toggle netrw keybind
	noremap <silent><leader>n :call ToggleNetrw()<CR>

" Pandoc markdown -> pdf compilation
	augroup my_markdown
		autocmd!
		autocmd FileType markdown nnoremap <F9> :<c-u>silent call system('pandoc -s '.expand('%:p:S').' -o '.expand('%:p:r:S').'.pdf')<cr>
	augroup END

" Tab controls (Alt+Left/Right)
	nnoremap <M-Left> :tabprevious<CR>
	nnoremap <M-Right> :tabnext<CR>

" Easily move lines up and down
	nnoremap <c-Down> :m .+1<CR>==
	nnoremap <c-Up> :m .-2<CR>==
	inoremap <c-Down> <ESC>:m .+1<CR>==gi
	inoremap <c-Up> <ESC>:m .-2<CR>==gi
	vnoremap <c-Down> :m '>+1<CR>gv=gv
	vnoremap <c-Up> :m '<-2<CR>gv=gv

" Telescope (fuzzy finder mappings)
" Find files using Telescope command-line sugar.
	nnoremap <leader>ff <cmd>Telescope find_files<cr>
	nnoremap <leader>fg <cmd>Telescope live_grep<cr>
	nnoremap <leader>fb <cmd>Telescope buffers<cr>
	nnoremap <leader>fh <cmd>Telescope help_tags<cr>

"""""" COC Autocompletion configuration
"" Use tab for trigger completion with characters ahead and navigate.
"" Use command ':verbose imap <tab>' to make sure tab is not mapped by other plugin.
"inoremap <silent><expr> <TAB>
"      \ pumvisible() ? "\<C-n>" :
"      \ <SID>check_back_space() ? "\<TAB>" :
"      \ coc#refresh()
"inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"
"
"function! s:check_back_space() abort
"  let col = col('.') - 1
"  return !col || getline('.')[col - 1]  =~# '\s'
"endfunction
"
"" Use <c-space> to trigger completion.
"inoremap <silent><expr> <c-space> coc#refresh()
"
"" Use <cr> to confirm completion, `<C-g>u` means break undo chain at current position.
"" Coc only does snippet and additional edit on confirm.
"inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
"" Or use `complete_info` if your vim support it, like:
"" inoremap <expr> <cr> complete_info()["selected"] != "-1" ? "\<C-y>" : "\<C-g>u\<CR>"
"
"" Use `[g` and `]g` to navigate diagnostics
"nmap <silent> [g <Plug>(coc-diagnostic-prev)
"nmap <silent> ]g <Plug>(coc-diagnostic-next)
"
"" Remap keys for gotos
"nmap <silent> gd <Plug>(coc-definition)
"nmap <silent> gy <Plug>(coc-type-definition)
"nmap <silent> gi <Plug>(coc-implementation)
"nmap <silent> gr <Plug>(coc-references)
"
"" Remap for rename current word
"nmap <leader>rn <Plug>(coc-rename)
"
"" Remap for format selected region
"xmap <leader>f  <Plug>(coc-format-selected)
"nmap <leader>f  <Plug>(coc-format-selected)
"
"" Add status line support, for integration with other plugin, checkout `:h coc-status`
"set statusline^=%{coc#status()}%{get(b:,'coc_current_function','')}
"
"" Which filetypes to enable Coc autocompletion
"let g:coc_filetypes_enable = [ 'c', 'cpp', 'html', 'js', 'rs', 'asm', 'lua', 'json', 'yml', 'vim', 'py']
"
"function! s:disable_coc_for_type()
"  if index(g:coc_filetypes_enable, &filetype) == -1
"    :silent! CocDisable
"  else
"    :silent! CocEnable
"  endif
"endfunction
"
"augroup CocGroup
" autocmd!
" autocmd BufNew,BufEnter,BufAdd,BufCreate * call s:disable_coc_for_type()
"augroup end
"
"
