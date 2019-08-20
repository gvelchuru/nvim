 "YCM {
 if !exists('g:ycm_semantic_triggers')
   let g:ycm_semantic_triggers = {}
 endif
 let g:ycm_confirm_extra_conf = 0
 let g:ycm_show_diagnostics_ui = 0
 let g:ycm_collect_identifiers_from_tags_files = 1 "}
"}
let g:UltiSnipsExpandTrigger="<c-b>"
"let g:UltiSnipsJumpForwardTrigger="<c-b>"
"let g:UltiSnipsJumpBackwardTrigger="<c-z>"


let g:lion_squeeze_spaces = 1

"INIT_BRACE {
  function! plugins#_brace() abort
    augroup python
      autocmd!
      autocmd FileType python BracelessEnable +fold +highlight
    augroup END
  endfunction
"}

"PEAR {
  let g:pear_tree_smart_openers = 1
  let g:pear_tree_smart_closers = 1
  let g:pear_tree_smart_backspace = 1
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
"INIT_TEX {
  function! plugins#_tex() abort
      augroup tex
        autocmd!
        au BufNewFile,BufRead *.tex set filetype=tex
      augroup END
      let g:tex_flavor = 'latex'
      if !exists('g:ycm_semantic_triggers')
        let g:ycm_semantic_triggers = {}
      endif
      au VimEnter * let g:ycm_semantic_triggers.tex=g:vimtex#re#youcompleteme
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
