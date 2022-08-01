scriptencoding utf-8
" COC {
let g:coc_global_extensions = ['coc-vimtex', 'coc-ultisnips', 'coc-yank', 'coc-json', 'coc-yaml', 'coc-python', 'coc-sh', 'coc-git', 'coc-tsserver', 'coc-powershell', 'coc-omnisharp', 'coc-rls', 'coc-java', 'coc-lua']

  function! s:check_back_space() abort 
    let col = col('.') - 1
    return !col || getline('.')[col - 1]  =~ '\s'
  endfunction

  inoremap <silent><expr> <TAB> coc#pum#visible() ? coc#pum#next(1):  <SID>check_back_space() ? "\<Tab>" :  coc#refresh()
  inoremap <silent><expr><S-TAB> coc#pum#visible() ? coc#pum#prev(1) : "\<C-h>"

 if has('nvim')                                                                                                                                                                                                                                                                                                                                                                                                                              
    inoremap <silent><expr> <c-space> coc#refresh()                                                                                                                                                                                                                                                                                                                                                                                           
  else                                                                                                                                                                                                                                                                                                                                                                                                                                        
    inoremap <silent><expr> <c-@> coc#refresh()                                                                                                                                                                                                                                                                                                                                                                                               
  endif

  inoremap <silent><expr> <cr> coc#pum#visible() ? coc#_select_confirm() : "\<CR>"

  inoremap <silent><expr> <TAB>

let g:UltiSnipsExpandTrigger='<c-k>'
let g:UltiSnipsJumpForwardTrigger="<c-l>"
let g:UltiSnipsJumpBackwardTrigger="<c-h>"

" Remap keys for gotos
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

"NERD
let g:NERDCompactSexyComs = 1
map <C-n> :NERDTreeToggle<CR>

"remap fzf
nnoremap <C-P> :FZF <cr>

" Use K to show documentation in preview window
nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction

nmap <leader>rn <Plug>(coc-rename)

"" Remap for do codeAction of selected region, ex: `<leader>aap` for current paragraph
"xmap <leader>a  <Plug>(coc-codeaction-selected)
"nmap <leader>a  <Plug>(coc-codeaction-selected)

"" Remap for do codeAction of current line
nmap <leader>ac  <Plug>(coc-codeaction)
"}

let g:lion_squeeze_spaces = 1

"ACK {
let g:ackprg = 'rg --vimgrep --type-not sql --smart-case'

" Auto close the Quickfix list after pressing '<enter>' on a list item
"let g:ack_autoclose = 1

" Any empty ack search will search for the work the cursor is on
let g:ack_use_cword_for_empty_search = 1

" Don't jump to first match
cnoreabbrev Ack Ack!
"}

"INIT_BRACE {
  function! plugins#_brace() abort
    augroup python
      autocmd!
      autocmd FileType python BracelessEnable +fold +highlight
    augroup END
  endfunction
"}

call neomake#configure#automake('nrwi', 500)

"ALE {
  let g:ale_linters = {
  \   '*' : ['remove_trailing_lines', 'trim_whitespace'],
  \   'java': ['google_java_format', 'uncrustify', 'pmd', 'eclipselsp'],
  \}
  let g:ale_fixers = {
  \   '*' : ['remove_trailing_lines', 'trim_whitespace'],
  \   'python' : ['isort', 'black'],
  \   'cpp' : ['clang-format', 'uncrustify'],
  \   'c': ['clang-format', 'uncrustify'],
  \   'cs': ['ale-cs-csc', 'uncrustify'],
  \   'haskell': ['brittany', 'hfmt'],
  \   'ruby': ['rubocop'],
  \   'tex': ['textlint'],
  \   'java': ['google_java_format', 'uncrustify'],
  \   'typescript': ['tslint', 'prettier']
  \}
  let g:ale_set_signs = 1
  let g:ale_set_highlights = 0
  let g:ale_lint_on_enter = 1
  let g:ale_lint_on_save = 1
  let g:ale_lint_on_text_changed = 1
  let g:ale_lint_on_insert_leave = 1
  let g:ale_fix_on_save = 0
" }
"CCLS {
  au CursorHold * sil call CocActionAsync('highlight')
  au CursorHoldI * sil call CocActionAsync('showSignatureHelp')
"}
"INIT_TEX {
  function! plugins#_tex() abort
      augroup tex
        autocmd!
        au BufNewFile,BufRead *.tex set filetype=tex
      augroup END
      let g:tex_flavor = 'latex'
      let g:vimtex_view_automatic = 1
  endfunction
"}

"AIRLINE {
  let g:airline_theme='solarized'
  let g:airline_solarized_bg='light'
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

  " powerline symbols let g:airline_left_sep = ''
  let g:airline_left_alt_sep = ''
  let g:airline_right_sep = ''
  let g:airline_right_alt_sep = ''
  let g:airline_symbols.branch = ''
  let g:airline_symbols.readonly = ''
  let g:airline_symbols.maxlinenr = ''
"}

