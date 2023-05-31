"pre-plugins settings
lua << END
vim.g.loaded = 1
vim.g.loaded_netrwPlugin = 1
END

let g:ale_disable_lsp = 1
if has('win32') || has('win64')
      source $HOME\AppData\Local\nvim\settings.vim
      source $HOME\AppData\Local\nvim\plugins.vim
else
      source $HOME/.config/nvim/settings.vim
      source $HOME/.config/nvim/plugins.vim
endif
syntax enable

lua require('plugins')

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
  if has('termguicolors')
          set termguicolors
  endif

  " Load the colorscheme
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


lua << EOF
require('treesitter')
require('telescope').setup {
    extensions = {
        fzy_native = {
            override_generic_sorter = false,
            override_file_sorter = true, }, 
        coc = { theme = 'ivy' }
    }
}
require('telescope').load_extension('fzy_native')
require('telescope').load_extension('coc')
EOF
