set encoding=utf-8
scriptencoding utf-8
let mapleader = ','
let maplocalleader = ','
noremap \ ,
set wildmode=full
set history=200

noremap <C-]> <C-W><C-]>
cnoremap sudow w !sudo tee % >/dev/null
"expand active buffer path
cnoremap <expr> %% getcmdtype() == ':' ? expand ('%:h').'/' : '%%'


if !exists('g:ycm_semantic_triggers')
    let g:ycm_semantic_triggers = {}
endif

let g:lion_squeeze_spaces = 1
set completeopt-=preview
set pumblend=30

let g:UltiSnipsJumpForwardTrigger='<c-b>'
let g:UltiSnipsJumpBackwardTrigger='<c-z>'

set rtp+=/usr/share/vim/vimfiles
if dein#load_state('~/.cache/dein')
    call dein#begin('~/.cache/dein')

    "PY
    call dein#add('tweekmonster/braceless.vim', {'on_ft': 'py', 'hook_source': 'call init#_brace()'})

    "TEX
    call dein#add('lervag/vimtex', {'on_ft': 'tex', 'hook_source': 'call init#_tex()'})

    "AESTHETIC
    call dein#add('gvelchuru/gruvbox')
    call dein#add('mhinz/vim-startify')
    call dein#add('junegunn/rainbow_parentheses.vim')
    call dein#add('vim-airline/vim-airline')
    call dein#add('lilydjwg/colorizer', {'on_ft': ['html', 'css']}) "color html codes
    call dein#add('ryanoasis/vim-devicons') "nice icons
    call dein#add('tommcdo/vim-lion') "Alignment
    call dein#add('tpope/vim-sleuth') "heuristically set indent
    call dein#add('ncm2/float-preview.nvim') "show preview in floating window

    "TEXT OBJECTS
    call dein#add('tpope/vim-repeat')
    call dein#add('tpope/vim-unimpaired')

    "SNIPPETS
    call dein#add('SirVer/ultisnips')
    call dein#add('honza/vim-snippets')


    "SEARCH
    "call dein#add('ctrlpvim/ctrlp.vim', {'on_map': '<C-P>'})
    call dein#add('easymotion/vim-easymotion', {'on_map': '<Leader><Leader>'})
    "call dein#add('scrooloose/nerdtree', {'on_cmd': 'NERDTreeToggle'})
    "call dein#add('majutsushi/tagbar')
    call dein#add('ludovicchabant/vim-gutentags')
    call dein#add('skywind3000/gutentags_plus')

    "GIT
    call dein#add('tpope/vim-fugitive') "TODO: cmd
    "call dein#add('airblade/vim-gitgutter')

    "SURROUND
    call dein#add('scrooloose/nerdcommenter', {'on_map': ['<Leader>cc', '<Leader>c<space>', '<Leader>cs']})
    call dein#add('tpope/vim-surround') "TODO: mappings
    call dein#add('tmsvg/pear-tree')
    call dein#add('wellle/targets.vim')
    call dein#add('michaeljsmith/vim-indent-object') "TODO: mappings

    "COMPLETION/LINTING
    call dein#add('w0rp/ale') "TODO: LSP functions
    call dein#add('Valloric/YouCompleteMe', {'build': './install.py --clang-completer'})
    call dein#add('rdnetto/YCM-Generator', {'on_cmd': 'YcmGenerateConfig'})

    "GENERAL
    call dein#add('christoomey/vim-tmux-navigator')
    call dein#add('wakatime/vim-wakatime')
    call dein#add('tweekmonster/startuptime.vim', {'on_cmd': 'StartupTime'})

    "C
    call dein#add('justinmk/vim-syntax-extra', {'on_ft': 'c'})

    "TESTING/ETC
"Plug 'tpope/vim-obsession'
"Plug 'dhruvasagar/vim-prosession'
"Plug 'TaDaa/vimade'
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
syntax on

set conceallevel=2

let g:ycm_confirm_extra_conf = 0
let g:ycm_show_diagnostics_ui = 0

set autoindent
set cindent
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
  augroup python
    autocmd!
    autocmd FileType python BracelessEnable +fold +highlight
  augroup END
endfunction

"ALE
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
let g:ale_lint_on_text_changed = 'never'
let g:ale_lint_on_save ='always'
let g:ale_lint_on_enter = 'never'
let g:ale_set_signs = 0
let g:ale_set_highlights = 1

nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>

inoremap <expr> <C-j> pumvisible() ? "\<C-N>" : "\<C-j>"
inoremap <expr> <C-k> pumvisible() ? "\<C-P>" : "\<C-k>"

augroup dein_update
  autocmd!
  au VimEnter * silent call dein#update()
  au VimEnter * silent call dein#remote_plugins()
augroup END

" COLORS
set termguicolors
let $NVIM_TUI_ENABLE_TRUE_COLOR=1
augroup highlights
  autocmd!
  autocmd ColorScheme * highlight Normal guibg=NONE ctermbg=NONE
augroup END
colorscheme gruvbox
let g:gruvbox_italic=1
let g:gruvbox_contrast_dark= 'soft'
set background=dark

"INIT_TEX
function! init#_tex() abort
    augroup tex
      autocmd!
      au BufNewFile,BufRead *.tex set filetype=tex
    augroup END
    let g:tex_flavor = 'latex'
    let g:ycm_semantic_triggers.tex = g:vimtex#re#youcompleteme
    let g:vimtex_view_automatic = 1
    let g:vimtex_compiler_method = 'latexmk'
    let g:vimtex_view_general_viewer = 'evince'
endfunction

"AIRLINE
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

"COLORIZER
let g:colorizer_auto_color = 1

"RAINBOW
let g:rainbow#pairs = [['(', ')'], ['[', ']'], ['{', '}']]
augroup enter
  autocmd!
  au VimEnter * RainbowParentheses
augroup END
