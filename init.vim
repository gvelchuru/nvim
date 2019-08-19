source $HOME/.config/nvim/dein.vim
source $HOME/.config/nvim/plugins.vim
source $HOME/.config/nvim/settings.vim

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

let g:UltiSnipsJumpExpandTrigger='<C-j>'
let g:UltiSnipsJumpForwardTrigger='<C-j>'
let g:UltiSnipsJumpBackwardTrigger='<C-k>'


"FOLDING {
  set foldenable
  set foldmethod=indent
  set foldlevel=99
  nnoremap <space> za
"}

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
