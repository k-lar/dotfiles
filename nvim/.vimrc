"  _    _            ( )               _
" | |__| | __ _  _ _  \| ___     __ __(_) _ __   _ _  __
" | / /| |/ _` || '_|   (_-/     \ V /| || '  \ | '_|/ _|
" |_\_\|_|\__/_||_|     /__/      \_/ |_||_|_|_||_|  \__|
"

let mapleader =" "

" PLUGINS {{{
" ======================================

" Download vim-plug if not found
if ! filereadable(system('echo -n "${XDG_CONFIG_HOME:-$HOME/.config}/vim/autoload/plug.vim"'))
	echo "Downloading junegunn/vim-plug to manage plugins..."
	silent !mkdir -p ${XDG_CONFIG_HOME:-$HOME/.config}/vim/autoload/
	silent !curl "https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim" > ${XDG_CONFIG_HOME:-$HOME/.config}/vim/autoload/plug.vim
	autocmd VimEnter * PlugInstall
endif

call plug#begin('~/.vim/plugged')
" Misc
Plug 'folke/zen-mode.nvim'
Plug 'junegunn/fzf.vim', { 'on': [ 'Files', 'Rg' ] }
Plug 'fladson/vim-kitty', { 'for': 'kitty' }
Plug 'dkarter/bullets.vim', { 'for': 'markdown' }
Plug 'terryma/vim-expand-region'
Plug 'unblevable/quick-scope'
Plug 'tpope/vim-fugitive'
Plug 'airblade/vim-gitgutter', { 'on': 'GitGutterToggle' }
Plug 'morhetz/gruvbox'
Plug 'nvim-lualine/lualine.nvim'
Plug 'rinx/nvim-minimap'
Plug 'dhruvasagar/vim-table-mode'
Plug 'mhinz/vim-startify'
Plug 'tpope/vim-commentary'

" Coding plugins
Plug 'mattn/emmet-vim'
Plug 'neovim/nvim-lspconfig'
Plug 'williamboman/mason.nvim'
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'} "Update parser on update

" Autocompletion
Plug 'hrsh7th/nvim-cmp'
Plug 'hrsh7th/cmp-nvim-lsp'
Plug 'hrsh7th/cmp-buffer'
Plug 'hrsh7th/cmp-path'
Plug 'hrsh7th/cmp-cmdline'

call plug#end()

" ======================================
" }}}


" Some basics: {{{
	syntax on
	filetype plugin on
	set encoding=utf-8
	set number relativenumber
	set clipboard+=unnamedplus
	set noshowmode " Don't show INSERT mode (for use with lightline)
	set ignorecase
	set smartcase
	set smarttab
	set scrolloff=1
	set sidescrolloff=3
	set mouse=a
	set path+=**
	set expandtab
	set tabstop=4
	set shiftwidth=4
" }}}


" Tmux status bar toggle on VimEnter {{{
    if has_key(environ(), 'TMUX')
      augroup tmux_something
        autocmd VimResume  * call system('tmux set status off')
        autocmd VimEnter   * call system('tmux set status off')
        autocmd VimLeave   * call system('tmux set status on')
        autocmd VimSuspend * call system('tmux set status on')
      augroup END
    endif
"}}}


" startify config {{{
let g:startify_custom_header=[
\'',
\'  ██╗  ██╗██╗      █████╗ ██████╗       ██╗   ██╗██╗███╗   ███╗',
\'  ██║ ██╔╝██║     ██╔══██╗██╔══██╗      ██║   ██║██║████╗ ████║',
\'  █████╔╝ ██║     ███████║██████╔╝█████╗██║   ██║██║██╔████╔██║',
\'  ██╔═██╗ ██║     ██╔══██║██╔══██╗╚════╝╚██╗ ██╔╝██║██║╚██╔╝██║',
\'  ██║  ██╗███████╗██║  ██║██║  ██║       ╚████╔╝ ██║██║ ╚═╝ ██║',
\'  ╚═╝  ╚═╝╚══════╝╚═╝  ╚═╝╚═╝  ╚═╝        ╚═══╝  ╚═╝╚═╝     ╚═╝',
\'',
\]


let g:startify_lists = [
\ { 'type': 'bookmarks', 'header': ['   Bookmarks']      },
\ { 'type': 'files',     'header': ['   MRU']            },
\ { 'type': 'dir',       'header': ['   MRU '. getcwd()] },
\ { 'type': 'sessions',  'header': ['   Sessions']       },
\ { 'type': 'commands',  'header': ['   Commands']       },
\ ]

let g:startify_bookmarks = [
\ {'v': '~/.vimrc'}, {'b': '~/.bashrc'},
\ ]

" }}}


" Journaling {{{
	augroup journal
    		autocmd!

		" populate journal template
		autocmd VimEnter */journal/**   0r ~/.config/nvim/templates/journal.skeleton
	augroup end

" }}}


" Abbreviations / aliases {{{
	iabbrev ip IP
	iabbrev ipv6 IPv6
	iabbrev ipv4 IPv4
	iabbrev dhcp DHCP
" }}}


" Colorscheme config (gruvbox) {{{
	colorscheme gruvbox
	set background=dark
 " }}}


" Lualine configuration {{{
lua << EOF
local custom_gruvbox = require'lualine.themes.gruvbox'

-- Change the background of lualine_a section for insert mode
custom_gruvbox.insert.a.bg = '#84a799'

require('lualine').setup {
  options = { theme  = custom_gruvbox },
  ...
}
EOF
" }}}


" zen-mode configuration {{{
map <silent> <leader>g :ZenMode<CR>

lua << EOF
require("zen-mode").setup {
	window = {
		backdrop = 1, -- shade the backdrop of the Zen window. Set to 1 to keep same
    		width = .85, -- width will be 85% of the editor width
		options = {
			number = false,
			relativenumber = false,
		},
  	},
}
EOF
" }}}


" nvim-minimap configuratio nvim-minimap configuration {{{
	nnoremap <leader>m :MinimapToggle <cr>

	let g:minimap#window#width = 20
	let g:minimap#window#height = 20
" }}}


" Remap ESC => CapsLock in vim only DEPRECATED (Now using systemwide esc>capslock) {{{
" '1>/dev/null 2>&1 &' sends xmodmap warning on Shift+ZZ/ZQ to /dev/null
"	au VimEnter * silent: !xmodmap -e 'clear Lock' -e 'keycode 0x42 = Escape' 1>/dev/null 2>&1 &
"	au VimLeave * silent: !xmodmap -e 'clear Lock' -e 'keycode 0x42 = Caps_Lock' 1>/dev/null 2>&1 &
" }}}


" f and t movements (quick-scope plugin) highlight on keypress {{{
	let g:qs_highlight_on_keys = ['f', 'F', 't', 'T']
	" }}}


" Markdown syntaxing and QOL featuzres: {{{
" Front of file (title, author, layout...) color change
	au BufNewFile,BufFilePre,BufRead *.md set filetype=markdown
	au BufNewFile,BufRead,BufWrite *.md syntax match Comment /\%^---\_.\{-}---$/
	au filetype markdown :iabbrev txtred \textcolor{red}{}<Left>
	au filetype markdown :iabbrev txtblu \textcolor{blue}{}<Left>
	au filetype markdown :iabbrev uline \underline{}<Left>

" Larger text width in terminal for easier readability (In markdown files)
	au FileType markdown setlocal textwidth=100
	au FileType vimwiki setlocal textwidth=100

" Markdown fenced languages list (syntax highlighting code inside markdown docs)
	let g:markdown_fenced_languages = ['python', 'html', 'c', 'vim', 'rust', 'bash', 'sql']

" Stop vimwiki from taking over markdown files outside wiki directories
	let g:vimwiki_global_ext = 0

" vim-table-mode setup for use with markdown (primarily)
	let g:table_mode_corner='|'

" Automatically deletes all trailing whitespaces on save (except .md files)
	fun! StripTrailingWhiteSpace()
  	" don't strip on these filetypes
  	if &ft =~ 'markdown'
    	return
  	endif
  	%s/\s\+$//e
	endfun
	autocmd BufWritePre * :call StripTrailingWhiteSpace()

" Spell checking in English
	map <leader>e :setlocal spell! spelllang=en_us<CR>

" Spell checking in Slovene
	map <silent> <leader>s :setlocal spell! spelllang=sl_si<CR><CR>

" Splits open at the bottom and right, which is non-retarded, unlike vim defaults.
	set splitbelow splitright

" Pandoc markdown -> pdf compilation
	augroup my_markdown
		autocmd!
		autocmd FileType markdown nnoremap <silent><F9> :<c-u>call system('pandoc -s '.expand('%:p:S').' -o '.expand('%:p:r:S').'.pdf')<cr>
		autocmd FileType markdown nnoremap <silent><F8> :<c-u>call system('zathura '.expand('%:p:r:S').'.pdf &')<cr>
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

" Set undo break points for certain characters (sensible undo)
	inoremap , ,<c-g>u
	inoremap . .<c-g>u
	inoremap ! !<c-g>u
	inoremap ? ?<c-g>u

" See whitespaces toggle
	set listchars=tab:>-,trail:·,extends:>,precedes:<
	map <silent><leader>ws :set list!<CR>

" Folding in vim filetype
	autocmd FileType vim setlocal foldmethod=marker

" Folding in markdown
	let g:markdown_folding = 1
	map <silent><leader>fd :set nofoldenable!<CR>

" }}}


" Coding config + QOL features {{{
" Vim autocompletion config (omnifunc)
	set wildmode=longest,list,full
	set wildignore=*.pdf,*.docx
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

	augroup python_run
		autocmd!
		autocmd FileType python nnoremap <silent><F5> :!python %<cr>
	augroup END

" Disables automatic commenting on new line
	autocmd FileType * setlocal formatoptions-=c formatoptions-=r formatoptions-=o

" Tree-sitter config
lua << EOF

local configs = require'nvim-treesitter.configs'
configs.setup {
ensure_installed = { "c", "lua", "python",  "bash", "bibtex", "cpp", "yaml", "vim", "cmake" },
highlight = { -- enable highlighting
  enable = true,
},
indent = {
  enable = false, -- default is disabled anyways
}
}

EOF

" Mason.nvim config
lua require("mason").setup()

" LSP config
" Language servers setup
lua require'lspconfig'.pyright.setup{}
lua require'lspconfig'.vimls.setup{}

" Keymaps for LSP
nnoremap gd :lua vim.lsp.buf.definition()<cr>
nnoremap gD :lua vim.lsp.buf.declaration()<cr>
nnoremap gi :lua vim.lsp.buf.implementation()<cr>
nnoremap gw :lua vim.lsp.buf.document_symbol()<cr>
nnoremap gw :lua vim.lsp.buf.workspace_symbol()<cr>
nnoremap gr :lua vim.lsp.buf.references()<cr>
nnoremap gt :lua vim.lsp.buf.type_definition()<cr>
nnoremap K  :lua vim.lsp.buf.hover()<cr>
nnoremap <c-k> :lua vim.lsp.buf.signature_help()<cr>
nnoremap <leader>af :lua vim.lsp.buf.code_action()<cr>
nnoremap <leader>rn :lua vim.lsp.buf.rename()<cr>

" }}}


" Autocompletion {{{
lua << EOF
  -- Setup nvim-cmp.
  local cmp = require'cmp'

  cmp.setup({
    window = {
      -- completion = cmp.config.window.bordered(),
      documentation = cmp.config.window.bordered(),
    },
    mapping = cmp.mapping.preset.insert({
      ['<C-b>'] = cmp.mapping.scroll_docs(-4),
      ['<C-f>'] = cmp.mapping.scroll_docs(4),
      ['<C-Space>'] = cmp.mapping.complete(),
      ['<C-e>'] = cmp.mapping.abort(),
      ['<CR>'] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
    }),
    sources = cmp.config.sources({
      { name = 'nvim_lsp' },
      -- { name = 'vsnip' }, -- For vsnip users.
      -- { name = 'luasnip' }, -- For luasnip users.
      -- { name = 'ultisnips' }, -- For ultisnips users.
      -- { name = 'snippy' }, -- For snippy users.
    }, {
      { name = 'buffer' },
    })
  })

  -- Set configuration for specific filetype.
  cmp.setup.filetype('markdown', {
    enabled = false,
  })

  cmp.setup({
    enabled =
      function ()
        buftype = vim.api.nvim_buf_get_option(0, "buftype")
	if buftype == "markdown" then return false end -- Turn off when in markdown buffer
      end
  })

  cmp.setup.filetype('vim', {
    enabled = false,
  })

  -- Use buffer source for `/` (if you enabled `native_menu`, this won't work anymore).
  -- cmp.setup.cmdline('/', {
  --   mapping = cmp.mapping.preset.cmdline(),
  --   sources = {
  --     { name = 'buffer' }
  --   }
  -- })

  -- -- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
  -- cmp.setup.cmdline(':', {
  --   mapping = cmp.mapping.preset.cmdline(),
  --   sources = cmp.config.sources({
  --     { name = 'path' }
  --   }, {
  --     { name = 'cmdline' }
  --   })
  -- })

  -- Setup lspconfig.
  local capabilities = require('cmp_nvim_lsp').update_capabilities(vim.lsp.protocol.make_client_capabilities())
  -- Replace <YOUR_LSP_SERVER> with each lsp server you've enabled.
  require('lspconfig')['pyright'].setup {
    capabilities = capabilities
  }
EOF

" Disable on certain filetypes
" autocmd FileType markdown lua require'cmp'.setup.buffer {
" \   completion = { autocomplete = false }
" \ }

" }}}


" Netrw config (vim's native file manager) {{{
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
" }}}


" Fuzzy finding (Using fzf) {{{
	nnoremap <leader>ff :Files<CR>
	nnoremap <leader>fg :Rg<CR>
" }}}


" Mouse toggle (useful for copying and pasting where vim is not compiled with +clipboard) {{{
	function! ToggleMouse()
	    " check if mouse is enabled
	    if &mouse == 'a'
	        " disable mouse
	        set mouse=
	    else
	        " enable mouse everywhere
	        set mouse=a
	    endif
	endfunc

	map <leader>M :call ToggleMouse()<CR>

" }}}


" Very simple TODO management {{{
	command Todo silent noautocmd vimgrep /\CTODO\+:\|\CFIXME\+:/g % | vert cwindow | winc =

	inoremap <F4>  <ESC>:Todo<cr>
	nnoremap <F4> :Todo<cr>
	inoremap <F3> <ESC>:cclose<cr>
	nnoremap <F3> :cclose<cr>
" }}}


" Git Gutter toggle {{{
	nnoremap <leader>G :GitGutterToggle<CR>
	let g:gitgutter_enabled = 0

" }}}
