"pre-plugins settings
let g:ale_disable_lsp = 1
if has("win32") || has("win64")
	source $HOME\AppData\Local\nvim\settings.vim
	source $HOME\AppData\Local\nvim\vim-plug.vim
	source $HOME\AppData\Local\nvim\plugins.vim
else
	source $HOME/.config/nvim/settings.vim
	source $HOME/.config/nvim/vim-plug.vim
	source $HOME/.config/nvim/plugins.vim
endif
syntax enable

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
  if (!(has("win32") || has("win64")) && has("termguicolors"))
    set termguicolors
  endif
  "let g:solarized_termcolors=16
  let g:solarized_bold=1
  let g:solarized_underline=1
  let g:solarized_italic=1
  set background=light
  "let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
  "let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
  colorscheme solarized
"}

augroup loading
  autocmd!
  autocmd Syntax c,cpp,cs,vim,xml,html,xhtml,perl normal zM

  " Instead of reverting the cursor to the last position in the buffer, we
  " set it to the first line when editing a git commit message
  au FileType gitcommit au! BufEnter COMMIT_EDITMSG call setpos('.', [0, 1, 1, 0])
  " Powershell
  au BufNewFile,BufRead   *.ps1   set ft=powershell
  au BufNewFile,BufRead   *.psd1  set ft=powershell
  au BufNewFile,BufRead   *.psm1  set ft=powershell
  au BufNewFile,BufRead   *.pssc  set ft=powershell
augroup END
