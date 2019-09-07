source $HOME/.config/nvim/settings.vim
source $HOME/.config/nvim/vim-plug.vim
source $HOME/.config/nvim/plugins.vim
syntax enable

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
        if exists('*mkdir')
            if !isdirectory(directory)
                call mkdir(directory)
            endif
        endif
        if !isdirectory(directory)
            echo 'Warning: Unable to create backup directory: ' . directory
            echo 'Try: mkdir -p ' . directory
        else
            let directory = substitute(directory, ' ', '\\\\ ', 'g')
            exec 'set ' . settingname . '=' . directory . '/'
        endif
    endfor
  endfunction
  call InitializeDirectories()
"}

"fzf and grep settings {
  "replace grep with rg
  if executable('rg')
    set grepprg=rg\ --vimgrep
    set grepformat=%f:%l:%c:%m,%f:%l:%m
  endif
  command! -bang -nargs=* Find call fzf#vim#grep('rg --column --line-number --no-heading --fixed-strings --ignore-case --no-ignore --hidden --follow --glob "!.git/*" --color "always" '.shellescape(<q-args>), 1, <bang>0)
"}

"FOLDING {
  set foldenable
  set foldmethod=indent
  set foldlevel=99
  nnoremap <space> za
"}

" COLORS {
  set termguicolors
  let $NVIM_TUI_ENABLE_TRUE_COLOR=1
  colorscheme gruvbox
  let g:gruvbox_italic=1
  let g:gruvbox_contrast_light='soft'
  set background=light
"}

augroup loading
  autocmd!

  autocmd BufEnter * syntax off
  "switch to current dir on load
  autocmd BufEnter * if bufname("") !~ '^\[A-Za-z0-9\]*://' && bufname("") !~ "list:///" | lcd %:p:h | endif

  " Instead of reverting the cursor to the last position in the buffer, we
  " set it to the first line when editing a git commit message
  au FileType gitcommit au! BufEnter COMMIT_EDITMSG call setpos('.', [0, 1, 1, 0])
augroup END
