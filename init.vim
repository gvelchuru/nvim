"set runtimepath^=~/.vim runtimepath+=~/.vim/after
"let &packpath = &runtimepath

let mapleader = ","
let maplocalleader = ","
noremap \ ,
":set lazyredraw
set wildmode=full
set history=200

"train to not use arrow keys
noremap <Up> <Nop>
noremap <Down> <Nop>
noremap <Left> <Nop>
noremap <Right> <Nop>

inoremap <silent> <CR> <C-r>=<SID>my_cr_function()<CR>
   function! s:my_cr_function() abort
     return deoplete#close_popup() . "\<CR>"
   endfunction                 

call plug#begin()
Plug 'w0rp/ale'
Plug 'donRaphaco/neotex', { 'for': 'tex' }
Plug 'tweekmonster/braceless.vim'
Plug 'lilydjwg/colorizer'
Plug 'ctrlpvim/ctrlp.vim'
Plug 'gvelchuru/gruvbox'
Plug 'scrooloose/nerdcommenter'
"Plug 'scrooloose/nerdtree'
"TODO: check branches for other ones, automated install
Plug 'python-mode/python-mode', {'branch': 'develop'}
Plug 'kien/rainbow_parentheses.vim'
Plug 'vim-airline/vim-airline'
"Plug 'vim-airline/vim-airline-themes'
Plug 'ryanoasis/vim-devicons'
Plug 'tpope/vim-fugitive'
Plug 'airblade/vim-gitgutter'
Plug 'mhinz/vim-startify'
Plug 'tpope/vim-surround'
Plug 'christoomey/vim-tmux-navigator' "TODO: learn this
Plug 'wakatime/vim-wakatime'
Plug 'lervag/vimtex'
Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins'}
Plug 'Shougo/neco-syntax'
Plug 'autozimu/LanguageClient-neovim', {
    \ 'branch': 'next',
    \ 'do': 'bash install.sh'
    \ }
Plug 'davidhalter/jedi'
Plug 'zchee/deoplete-jedi'
Plug 'artur-shaik/vim-javacomplete2'
call plug#end()

let g:deoplete#enable_at_startup=1
if !exists('g:deoplete#omni#input_patterns')
    let g:deoplete#omni#input_patterns = {}
endif 
let g:deoplete#omni#input_patterns.tex = g:vimtex#re#deoplete
set conceallevel=2



"let g:deoplete#disable_auto_complete = 1
autocmd InsertLeave,CompleteDone * if pumvisible() == 0 | pclose | endif

"augroup omnifuncs
    "autocmd!
    "autocmd FileType python setlocal omnifunc=pythoncomplete#Complete
"augroup end

call deoplete#custom#source('omni', 'functions', {
    \ 'python': 'pythoncomplete#Complete',
    \ 'vim' : ['vim']
    \})
"call deoplete#custom#source('_', 'sorters', ['sorter_word'])

inoremap <expr><tab> pumvisible() ? "\<c-n>" : "\<tab>"


set autoindent
set cindent
"set statusline+=set statusline+=%#warningmsg#
"set statusline+=%*
imap jj <Esc>
" imap jk <Esc>
set tabstop=4
set shiftwidth=4
set softtabstop=4
set expandtab
set number
set showcmd
set showmatch
set incsearch
set hlsearch
set ruler
set splitbelow
set splitright
set cursorline


 "Enable folding
"set foldmethod=indent
"set foldlevel=99
"nnoremap <space> za


let g:jedi#goto_command = ""
let g:jedi#goto_assignments_command = ""
let g:jedi#goto_definitions_command = ""
let g:jedi#documentation_command = ""
let g:jedi#usages_command = ""
let g:jedi#completions_command = ""
let g:jedi#rename_command = ""


"let g:auto_save=1


let g:pymode_options_max_line_length = 79
let g:pymode_options_colorcolumn = 0 
let g:pymode_python = 'python3'
let g:pymode_indent = 1
let g:pymode_folding = 0  
let g:pymode_motion = 0
"let g:pymode_doc = 1
"let g:pymode_doc_bind = '<leader>k'
let g:pymode_lint = 0
"let g:pymode_lint_on_fly = 1
let g:pymode_virtualenv = 1
let g:pymode_run = 1
let g:pymode_run_bind = '<Leader>r'
let g:pymode_rope_show_doc_bind = '<Leader>K'
let g:pymode_rope_regenerate_on_write = 1
let g:pymode_rope_autoimport_bind = '<leader>a'
let g:pymode_rope_goto_definition_bind = '<Leader>g'
"let g:pymode_rope_rename_bind = '<C-c>rr'
"let g:pymode_rope_autoimport_bind = '<C-c>ra'
let g:pymode_syntax = 1
let g:pymode_syntax_slow_sync = 1
let g:pymode_syntax_all = 1
let g:pymode_rope_completion = 0
"let g:pymode_lint_cwindow = 0
"let g:pymode_lint_unmodified = 1


autocmd FileType python BracelessEnable +fold +highlight


let g:ale_fixers = {
\    'python' : ['add_blank_lines_for_python_control_statements', 'autopep8', 'yapf', 'remove_trailing_lines', 'trim_whitespace'],
\   'cpp' : ['clang-format'],
\   'haskell': ['brittany', 'hfmt', 'remove_trailing_lines', 'trim_whitespace'],
\   'ruby': ['rubocop', 'remove_trailing_lines', 'trim_whitespace']
\}

let g:ale_fix_on_save=1
let g:ale_lint_on_text_changed = 'always'
"let g:ale_lint_on_save ='always'

nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>
" nnoremap <S-Tab> <<
" inoremap <S-Tab> <C-d>

inoremap <expr> <C-j> pumvisible() ? "\<C-N>" : "\<C-j>"
inoremap <expr> <C-k> pumvisible() ? "\<C-P>" : "\<C-k>"

let g:typescript_compiler_binary = 'tsc'
let g:typescript_compiler_options = ''


"autocmd VimEnter * NERDTree
autocmd VimEnter * wincmd p

"let g:NERDTreeUpdateOnWrite = 0

" highlight Normal ctermfg=grey ctermbg=black


" set Vim-specific sequences for RGB colors
"set termguicolors
let g:gruvbox_italic=1
let g:gruvbox_contrast_dark= 'soft'
colorscheme gruvbox
"colorscheme gotham
set background=dark
"highlight BadWhitespace ctermbg=red guibg=darkred
"au BufRead,BufNewFile *.py,*.pyw,*.c,*.h match BadWhitespace /\s\+$/

"python with virtualenv support
"py3 << EOF
"import os
"import sys
"if 'VIRTUAL_ENV' in os.environ:
  "project_base_dir = os.environ['VIRTUAL_ENV']
  "activate_this = os.path.join(project_base_dir, 'bin/activate_this.py')
  "execfile(activate_this, dict(__file__=activate_this))
"EOF

au BufNewFile,BufRead *.tex set filetype=tex
let g:tex_flavor = 'latex'
let g:neotex_latexdiff = 1

set encoding=utf-8
set guifont=Inconsolata\ 11
let g:airline_theme='gruvbox'
let g:airline_powerline_fonts = 1
let g:WebDevIconsNerdTreeGitPluginForceVAlign = 1
let g:airline#extensions#ale#enabled = 1



  if !exists('g:airline_symbols')
    let g:airline_symbols = {}
  endif

  " unicode symbols
  "let g:airline_left_sep = '»'
  "let g:airline_left_sep = '▶'
  "let g:airline_right_sep = '«'
  "let g:airline_right_sep = '◀'
  let g:airline_symbols.crypt = '🔒'
  "let g:airline_symbols.linenr = '☰'
  "let g:airline_symbols.linenr = '␊'
  "let g:airline_symbols.linenr = '␤'
  let g:airline_symbols.linenr = '¶'
  "let g:airline_symbols.maxlinenr = ''
  "let g:airline_symbols.maxlinenr = '㏑'
  "let g:airline_symbols.branch = '⎇'
  let g:airline_symbols.paste = 'ρ'
  "let g:airline_symbols.paste = 'Þ'
  "let g:airline_symbols.paste = '∥'
  let g:airline_symbols.spell = 'Ꞩ'
  let g:airline_symbols.notexists = '∄'
  let g:airline_symbols.whitespace = 'Ξ'

  " powerline symbols
  let g:airline_left_sep = ''
  let g:airline_left_alt_sep = ''
  let g:airline_right_sep = ''
  let g:airline_right_alt_sep = ''
  let g:airline_symbols.branch = ''
  let g:airline_symbols.readonly = ''
  "let g:airline_symbols.linenr = '☰'
  let g:airline_symbols.maxlinenr = ''

 "mine
 "let g:airline_left_sep = ''
 "let g:airline_right_sep = ''


let g:colorizer_auto_color = 1

"if !exists('g:ycm_semantic_triggers')
    "let g:ycm_semantic_triggers = {}
"endif
"let g:ycm_semantic_triggers.tex = g:vimtex#re#youcompleteme

"let g:vimtex_view_general_viewer = 'evince'

let g:rbpt_max = 16
let g:rbpt_loadcmd_toggle = 0

au VimEnter * RainbowParenthesesToggle
au Syntax * RainbowParenthesesLoadRound
au Syntax * RainbowParenthesesLoadSquare
au Syntax * RainbowParenthesesLoadBraces


hi Normal guibg=NONE ctermbg=NONE
hi! link ALEErrorSign GruvboxRed
hi! link ALEWarningSign GruvboxYellow
hi! link GitGutterChange GruvboxGreen
hi! link GitGutterAdd GruvboxGreen
hi! link GitGutterDelete GruvboxRed
":set mouse=a
"





