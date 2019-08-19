"Settings {
  set encoding=utf-8
  scriptencoding utf-8
  let mapleader = ','
  let maplocalleader = ','
  noremap \ ,
  set backspace=indent,eol,start
  set linespace=0
  set wildmode=longest,full
  set history=1000
  set spell
  set ignorecase
  set smartcase
  set autoindent
  set cindent
  set number
  set showcmd
  set showmatch
  set incsearch
  set hlsearch

  set splitbelow
  set splitright
  set cursorline
  set scrolljump=5
  set scrolloff=3
  set pastetoggle=<F12>

  set backup
  set undofile
  set undolevels=1000
  set undoreload=10000

  set viewoptions=cursor,folds,slash,unix

  set completeopt-=preview
  set pumblend=30
  set conceallevel=2 concealcursor=i
"}

"Remapping {
  noremap <C-]> <C-W><C-]>
  cnoremap sudow w !sudo tee % >/dev/null
  "expand active buffer path
  cnoremap <expr> %% getcmdtype() == ':' ? expand ('%:h').'/' : '%%'
  nnoremap <C-J> <C-W><C-J>
  nnoremap <C-K> <C-W><C-K>
  nnoremap <C-L> <C-W><C-L>
  nnoremap <C-H> <C-W><C-H>

  inoremap <expr> <C-j> pumvisible() ? "\<C-N>" : "\<C-j>"
  inoremap <expr> <C-k> pumvisible() ? "\<C-P>" : "\<C-k>"
  
  nnoremap & :&&<CR> 
  xnoremap & :&&<CR>
"}



"persistent undo {
  function! InitializeDirectories()
    let parent = $HOME
    let prefix = 'vim'
    let dir_list = {
                \ 'backup': 'backupdir',
                \ 'views': 'viewdir',
                \ 'swap': 'directory' }

    if has('persistent_undo')
        let dir_list['undo'] = 'undodir'
    endif

    let common_dir = parent . '/.' . prefix

    for [dirname, settingname] in items(dir_list)
        let directory = common_dir . dirname . '/'
        if exists("*mkdir")
            if !isdirectory(directory)
                call mkdir(directory)
            endif
        endif
        if !isdirectory(directory)
            echo "Warning: Unable to create backup directory: " . directory
            echo "Try: mkdir -p " . directory
        else
            let directory = substitute(directory, " ", "\\\\ ", "g")
            exec "set " . settingname . "=" . directory . '/'
        endif
    endfor
  endfunction
  call InitializeDirectories()
"}

"switch to current dir on load
autocmd BufEnter * if bufname("") !~ "^\[A-Za-z0-9\]*://" | lcd %:p:h | endif

" Instead of reverting the cursor to the last position in the buffer, we
" set it to the first line when editing a git commit message
au FileType gitcommit au! BufEnter COMMIT_EDITMSG call setpos('.', [0, 1, 1, 0])

" Ctags {
  set tags=./tags;/,~/.vimtags

  " Make tags placed in .git/tags file available in all levels of a repository
  let gitroot = substitute(system('git rev-parse --show-toplevel'), '[\n\r]', '', 'g')
  if gitroot != ''
    let &tags = &tags . ',' . gitroot . '/.git/tags'
  endif
"}

"Leader mapping {
  nnoremap <leader>a :argadd <c-r>=fnameescape(expand('%:p:h'))<cr>/*<C-d>
  nnoremap <leader>b :b <C-d>
  nnoremap <leader>e :e **/
  nnoremap <leader>g :grep<space>
  nnoremap <leader>i :Ilist<space>
  nnoremap <leader>j :tjump /
  nnoremap <leader>m :make<cr>
  nnoremap <leader>s :call StripTrailingWhitespace()<cr>
  nnoremap <leader>q :b#<cr>
  "nnoremap <leader>t :TTags<space>*<space>*<space>.<cr> need ttags
"}

"CTRLP and grep settings {
  "replace grep with ag
  if executable("ag")
    set grepprg=ag\ --nogroup\ --nocolor\ --ignore-case\ --column
    set grepformat=%f:%l:%c:%m,%f:%l:%m
  endif
  let g:ctrlp_working_path_mode = 'ra'
  let g:ctrlp_custom_ignore = {
    \ 'dir':  '\.git$\|\.hg$\|\.svn$',
    \ 'file': '\.exe$\|\.so$\|\.dll$\|\.pyc$'
  \}
  if executable('ag')
    let s:ctrlp_fallback = 'ag %s --nocolor -l -g ""'
  endif
  if exists("g:ctrlp_user_command")
    unlet g:ctrlp_user_command
  endif
  let g:ctrlp_user_command = {
        \ 'types': {
            \ 1: ['.git', 'cd %s && git ls-files . --cached --exclude-standard --others'],
            \ 2: ['.hg', 'hg --cwd %s locate -I .'],
        \ },
        \ 'fallback': s:ctrlp_fallback
  \ }
"}


"YCM {
  if !exists('g:ycm_semantic_triggers')
      let g:ycm_semantic_triggers = {}
  endif
  let g:ycm_confirm_extra_conf = 0
  let g:ycm_show_diagnostics_ui = 0
  let g:ycm_collect_identifiers_from_tags_files = 1
"}

let g:lion_squeeze_spaces = 1

let g:UltiSnipsJumpExpandTrigger='<C-j>'
let g:UltiSnipsJumpForwardTrigger='<C-j>'
let g:UltiSnipsJumpBackwardTrigger='<C-k>'

"Dein loading {
  set rtp+=/usr/share/vim/vimfiles
  if dein#load_state('~/.cache/dein')
      call dein#begin('~/.cache/dein')

      "PY
      call dein#add('tweekmonster/braceless.vim', {'on_ft': 'py', 'hook_source': 'call init#_brace()'})

      "TEX
      call dein#add('lervag/vimtex', {'on_ft': 'tex', 'hook_source': 'call init#_tex()'})

      "AESTHETIC
      call dein#add('gvelchuru/gruvbox') "my version of the gruvbox colorscheme
      call dein#add('mhinz/vim-startify') "start screen
      call dein#add('junegunn/rainbow_parentheses.vim') "colorize matching parens
      call dein#add('vim-airline/vim-airline') "line prompt on bottom
      call dein#add('lilydjwg/colorizer', {'on_ft': ['html', 'css']}) "color html codes
      call dein#add('ryanoasis/vim-devicons') "nice icons
      call dein#add('tommcdo/vim-lion') "Alignment
      call dein#add('tpope/vim-sleuth') "heuristically set indent
      call dein#add('ncm2/float-preview.nvim') "show preview in floating window

      "TEXT OBJECTS
      call dein#add('tpope/vim-repeat')
      call dein#add('tpope/vim-unimpaired')

      "SEARCH
      call dein#add('nelstrom/vim-visual-star-search') "perform search on the current visual selection

      "SNIPPETS
      call dein#add('SirVer/ultisnips')
      call dein#add('honza/vim-snippets')

      "SEARCH
      call dein#add('ctrlpvim/ctrlp.vim', {'on_map': '<C-P>'})
      call dein#add('easymotion/vim-easymotion', {'on_map': '<Leader><Leader>'})
      call dein#add('ludovicchabant/vim-gutentags')
      call dein#add('skywind3000/gutentags_plus')

      "GIT
      call dein#add('tpope/vim-fugitive') "TODO: cmd

      "SURROUND
      call dein#add('scrooloose/nerdcommenter', {'on_map': ['<Leader>cc', '<Leader>c<space>', '<Leader>cs']})
      call dein#add('tpope/vim-surround') "TODO: mappings
      call dein#add('tmsvg/pear-tree')
      call dein#add('wellle/targets.vim')
      call dein#add('michaeljsmith/vim-indent-object') "TODO: mappings

      "COMPLETION/LINTING
      call dein#add('dense-analysis/ale') "TODO: LSP functions
      call dein#add('Valloric/YouCompleteMe', {'build': './install.py --clang-completer'})
      call dein#add('rdnetto/YCM-Generator', {'on_cmd': 'YcmGenerateConfig'})

      "GENERAL
      call dein#add('christoomey/vim-tmux-navigator')
      call dein#add('wakatime/vim-wakatime')
      call dein#add('tweekmonster/startuptime.vim', {'on_cmd': 'StartupTime'})

      "C
      call dein#add('justinmk/vim-syntax-extra', {'on_ft': 'c'})

      "RESTORATION
      call dein#add('vim-scripts/restore_view.vim')

      call dein#end()
      call dein#save_state()
  endif
  if dein#check_install()
      call dein#install()
  endif
  augroup dein_update
    autocmd!
    au VimEnter * silent call dein#update()
    au VimEnter * silent call dein#remote_plugins()
  augroup END
"}
syntax on


"FOLDING {
  set foldenable
  set foldmethod=indent
  set foldlevel=99
  nnoremap <space> za
"}

"INIT_BRACE {
  function! init#_brace() abort
    augroup python
      autocmd!
      autocmd FileType python BracelessEnable +fold +highlight
    augroup END
  endfunction
"}

"ALE {
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
" }

" COLORS {
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
"}

"INIT_TEX {
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
"}

"AIRLINE {
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
"}

"COLORIZER
let g:colorizer_auto_color = 1

"RAINBOW {
  let g:rainbow#pairs = [['(', ')'], ['[', ']'], ['{', '}']]
  augroup enter
    autocmd!
    au VimEnter * RainbowParentheses
  augroup END
"}
