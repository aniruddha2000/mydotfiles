syntax enable

set shell=/bin/bash

set tabstop=4
set shiftwidth=4
set expandtab
set number
set autoindent
set ruler
set showcmd
set hlsearch
set wrap
set linebreak
set noswapfile
set incsearch
set nohlsearch
set ignorecase
set smartcase
set showmatch
set shortmess+=c
set showmode
set cursorline
set title
set clipboard=unnamedplus
set complete+=kspell
set completeopt=menuone,longest
set encoding=UTF-8

set nocompatible

" To set the custom colorscheme
"set termguicolors

set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

Plugin 'VundleVim/Vundle.vim'
Plugin 'scrooloose/nerdTree' "Documents tree
Plugin 'davidhalter/jedi-vim' "python autocompletion
Plugin 'scrooloose/syntastic' "code syntaxis
Plugin 'Raimondi/delimitMate' "automatic closing of quotes, parenthesis...
Plugin 'yggdroot/indentline' "Show indent lines (useful for loops)
Plugin 'vim-airline/vim-airline'
Plugin 'vim-airline/vim-airline-themes'
Plugin 'ervandew/supertab' "<Tab> for code completion
Plugin 'jistr/vim-nerdtree-tabs'
Plugin 'ntpeters/vim-better-whitespace'
Plugin 'python/black'
Plugin 'andviro/flake8-vim'
Plugin 'fatih/vim-go'
Plugin 'tpope/vim-commentary'
Plugin 'airblade/vim-gitgutter'
Plugin 'jreybert/vimagit'
Plugin 'ryanoasis/vim-devicons'
Plugin 'rakr/vim-one'
Plugin 'vim-scripts/AutoComplPop'

call vundle#end()

autocmd BufWritePre *.py execute ':Black'
let g:black_linelength = 79

let g:PyFlakeOnWrite = 1
let g:PyFlakeCheckers = 'pep8,mccabe,frosted'
let g:PyFlakeDefaultComplexity=10
let g:PyFlakeDisabledMessages = 'E1101,C0111,E1136,W0703,C0103,C0330,W504'
let g:PyFlakeAggressive = 0
let g:PyFlakeCWindow = 6
let g:PyFlakeSigns = 1
let g:PyFlakeSignStart = 1
let g:PyFlakeForcePyVersion = 3

filetype plugin indent on

set background=dark
" colorscheme one

" Go syntax highlighting
let g:go_highlight_fields = 1
let g:go_highlight_functions = 1
let g:go_highlight_function_calls = 1
let g:go_highlight_extra_types = 1
let g:go_highlight_operators = 1

" Go preview disable
set completeopt-=preview

" Auto formatting and importing
let g:go_fmt_autosave = 1
let g:go_fmt_command = "goimports"

" Status line types/signatures
let g:go_auto_type_info = 1

" Run :GoBuild or :GoTestCompile based on the go file
function! s:build_go_files()
  let l:file = expand('%')
  if l:file =~# '^\f\+_test\.go$'
    call go#test#Test(0, 1)
  elseif l:file =~# '^\f\+\.go$'
    call go#cmd#Build(0)
  endif
endfunction

" Map keys for most used commands.
" Ex: `\b` for building, `\r` for running and `\b` for running test.
autocmd FileType go nmap <leader>b :<C-u>call <SID>build_go_files()<CR>
autocmd FileType go nmap <leader>r  <Plug>(go-run)
autocmd FileType go nmap <leader>t  <Plug>(go-test)

au filetype go inoremap <buffer> . .<C-x><C-o>

" NERDTree setup
map <C-z> :NERDTreeToggle<CR> “ Toggle side window with `CTRL+z`.
let g:NERDTreeDirArrowExpandable = '▸'
let g:NERDTreeDirArrowCollapsible = '▾'
let NERDTreeShowHidden=1 " Show hidden files

" Vim airline
let g:airline_powerline_fonts=1
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#left_sep = ' '
let g:airline#extensions#tabline#left_alt_sep = '|'
let g:airline#extensions#tabline#formatter = 'default'
let g:airline#extensions#branch#enabled = 1
let g:airline#extensions#hunks#enabled = 1

" Vim airline themes
let g:airline_theme='one'

" Git Gutter
" Use fontawesome icons as signs
let g:gitgutter_sign_added = '+'
let g:gitgutter_sign_modified = '>'
let g:gitgutter_sign_removed = '-'
let g:gitgutter_sign_removed_first_line = '^'
let g:gitgutter_sign_modified_removed = '<'
let g:gitgutter_override_sign_column_highlight = 1
highlight SignColumn guibg=bg
" highlight SignColumn ctermbg=bg

set updatetime=250

nmap <Leader>gn <Plug>(GitGutterNextHunk)  " git next
nmap <Leader>gp <Plug>(GitGutterPrevHunk)  " git previous
nmap <Leader>ga <Plug>(GitGutterStageHunk)  " git add (chunk)
nmap <Leader>gu <Plug>(GitGutterUndoHunk)   " git undo (chunk)

" Open vimagit pane
nnoremap <leader>gs :Magit<CR>       " git status

" Move between buffers
map gn :bn<cr>
map gp :bp<cr>
map gd :bd<cr>

" Move line up and down
nnoremap K :m .-2<CR>==
nnoremap J :m .+1<CR>==
vnoremap K :m '<-2<CR>gv=gv
vnoremap J :m '>+1<CR>gv=gv

" Set Ctrl+h for highlight search
nnoremap <c-h> :set hlsearch!<cr>

" Disable K for documentation of go and py
let g:go_doc_keywordprg_enabled = 0
let g:jedi#documentation_command = 0

