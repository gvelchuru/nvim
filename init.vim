"set runtimepath^=~/.vim runtimepath+=~/.vim/after
"let &packpath = &runtimepath

let mapleader = ','
let maplocalleader = ','
noremap \ ,
":set lazyredraw
set wildmode=full
set history=200
imap jj <Esc>

inoremap <silent> <CR> <C-r>=<SID>my_cr_function()<CR>
   function! s:my_cr_function() abort
     return deoplete#close_popup() . "\<CR>"
   endfunction

noremap <C-]> <C-W><C-]>
nmap <C-N> :NERDTreeToggle<CR>

if &compatible
    set nocompatible
endif

set runtimepath+=~/.cache/dein/repos/github.com/Shougo/dein.vim

if !exists('g:ycm_semantic_triggers')
    let g:ycm_semantic_triggers = {}
endif

"TODO: check branches for other ones, automated install
if dein#load_state('~/.cache/dein')
    call dein#begin('~/.cache/dein')

    "PY
    call dein#add('tweekmonster/braceless.vim', {'on_ft': 'py', 'hook_source': 'call init#_brace()'})

    "TEX
    call dein#add('donRaphaco/neotex', {'on_ft': 'tex'})
    call dein#add('lervag/vimtex', {'on_ft': 'tex', 'hook_source': 'call init#_tex()'})

    "AESTHETIC
    call dein#add('gvelchuru/gruvbox')
    call dein#add('mhinz/vim-startify')
    call dein#add('kien/rainbow_parentheses.vim')
    call dein#add('vim-airline/vim-airline')
    call dein#add('lilydjwg/colorizer', {'on_ft': ['html', 'css']})
    call dein#add('ryanoasis/vim-devicons')

    "SEARCH
    call dein#add('ctrlpvim/ctrlp.vim', {'on_map': '<C-P>'})
    call dein#add('easymotion/vim-easymotion', {'on_map': '<Leader><Leader>'})
    call dein#add('scrooloose/nerdtree', {'on_cmd': 'NERDTreeToggle'})
    call dein#add('majutsushi/tagbar')
    call dein#add('ludovicchabant/vim-gutentags')

    "GIT
    call dein#add('tpope/vim-fugitive') "TODO: cmd
    call dein#add('airblade/vim-gitgutter')

    "SURROUND
    call dein#add('scrooloose/nerdcommenter', {'on_map': ['<Leader>cc', '<Leader>c<space>', '<Leader>cs']})
    call dein#add('tpope/vim-surround') "TODO: mappings
    call dein#add('tmsvg/pear-tree')

    "COMPLETION/LINTING
    call dein#add('w0rp/ale') "TODO: LSP functions
    call dein#add('Valloric/YouCompleteMe', {'build': './install.py --clang-completer'})
    call dein#add('rdnetto/YCM-Generator')

    "GENERAL
    call dein#add('christoomey/vim-tmux-navigator')
    call dein#add('wakatime/vim-wakatime')
    call dein#add('tweekmonster/startuptime.vim', {'on_cmd': 'StartupTime'})

    "C
    call dein#add('justinmk/vim-syntax-extra', {'on_ft': 'c'})

    "TESTING/ETC
"Plug 'tpope/vim-obsession'
"Plug 'dhruvasagar/vim-prosession'
"Plug 'artur-shaik/vim-javacomplete2'
"Plug 'TaDaa/vimade'
"Plug 'junegunn/limelight.vim'
"Plug 'junegunn/goyo.vim'
    "call dein#add('autozimu/LanguageClient-neovim', {
    "\ 'rev': 'next',
    "\ 'build': 'bash install.sh'
    "\ })
"    call dein#add('jeaye/color_coded', {
       " \ 'build' : 'rm -f CMakeCache.txt && cmake . && make && make install',
       " \ 'on_ft': ['c','cpp', 'objc', 'objcpp'],
       " \})
    call dein#end()
    call dein#save_state()
endif
if dein#check_install()
    call dein#install()
endif
filetype plugin on

set conceallevel=2

let g:ycm_confirm_extra_conf = 0
let g:ycm_show_diagnostics_ui = 0

"let g:deoplete#disable_auto_complete = 1
"autocmd InsertLeave,CompleteDone * if pumvisible() == 0 | pclose | endif

"inoremap <expr><tab> pumvisible() ? "\<c-n>" : "\<tab>"

set autoindent
set cindent
"set statusline+=set statusline+=%#warningmsg#
"set statusline+=%*
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


function! init#_brace() abort
    autocmd FileType python BracelessEnable +fold +highlight
endfunction

let g:ale_fixers = {
\   '*' : ['remove_trailing_lines', 'trim_whitespace'],
\   'python' : ['add_blank_lines_for_python_control_statements', 'autopep8', 'yapf', 'isort', 'black'],
\   'cpp' : ['clang-format', 'uncrustify'],
\   'c': ['clang-format', 'uncrustify'],
\   'haskell': ['brittany', 'hfmt'],
\   'ruby': ['rubocop'],
\   'tex': ['textlint'],
\   'java': ['google_java_format', 'uncrustify']
\}

let g:ale_fix_on_save=1
"let g:ale_lint_on_text_changed = 'always'
let g:ale_lint_on_text_changed = 'never'
let g:ale_lint_on_save ='always'
let g:ale_line_on_enter = 'never'

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


autocmd VimEnter * wincmd p
if $HOSTNAME !~ 'attu'
    autocmd VimEnter * silent call dein#update()
    autocmd VimEnter * silent call dein#remote_plugins()
endif

" highlight Normal ctermfg=grey ctermbg=black


" set Vim-specific sequences for RGB colors
"set termguicolors

"let $NVIM_TUI_ENABLE_TRUE_COLOR=1

let g:gruvbox_italic=1
let g:gruvbox_contrast_dark= 'soft'
colorscheme gruvbox
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


function! init#_tex() abort
    au BufNewFile,BufRead *.tex set filetype=tex
    let g:tex_flavor = 'latex'
    let g:neotex_latexdiff = 1
    let g:ycm_semantic_triggers.tex = g:vimtex#re#youcompleteme
endfunction

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
let g:airline_symbols.crypt = '🔒'
let g:airline_symbols.linenr = '¶'
let g:airline_symbols.paste = 'ρ'
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
let g:airline_symbols.maxlinenr = ''

"mine
"let g:airline_left_sep = ''
"let g:airline_right_sep = ''


let g:colorizer_auto_color = 1
let g:vimtex_view_general_viewer = 'evince'
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
"let g:limelight_conceal_ctermfg = 'gray'
"au VimEnter * Limelight
