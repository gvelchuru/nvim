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
  set foldmethod=syntax
  set foldnestmax=3
  set foldlevel=2
  set foldenable
  nnoremap <space> za
"}

" COLORS {
  let $NVIM_TUI_ENABLE_TRUE_COLOR=1
  let g:solarized_termcolors=16
  let g:solarized_bold=1
  let g:solarized_underline=1
  let g:solarized_italic=1
  set background=light
  colorscheme solarized
  if (has("termguicolors"))
    set termguicolors
  endif
"}

augroup loading
  autocmd!
  autocmd Syntax c,cpp,vim,xml,html,xhtml,perl normal zM

  " Instead of reverting the cursor to the last position in the buffer, we
  " set it to the first line when editing a git commit message
  au FileType gitcommit au! BufEnter COMMIT_EDITMSG call setpos('.', [0, 1, 1, 0])
augroup END
