"Dein loading {
  set rtp+=/usr/share/vim/vimfiles
  if dein#load_state('~/.cache/dein')
      call dein#begin('~/.cache/dein')

      "PY
      call dein#add('tweekmonster/braceless.vim', {'on_ft': 'py', 'hook_source': 'call plugins#_brace()'})

      "TEX
      call dein#add('lervag/vimtex', {'on_ft': 'tex', 'hook_source': 'call plugins#_tex()'})

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
      call dein#add('tpope/vim-rhubarb')

      "SURROUND
      call dein#add('scrooloose/nerdcommenter', {'on_map': ['<Leader>cc', '<Leader>c<space>', '<Leader>cs']})
      call dein#add('tpope/vim-surround') "TODO: mappings
      call dein#add('tmsvg/pear-tree')
      call dein#add('wellle/targets.vim')
      call dein#add('michaeljsmith/vim-indent-object') "TODO: mappings

      "COMPLETION/LINTING
      call dein#add('dense-analysis/ale') "TODO: LSP functions
      call dein#add('Shougo/deoplete.nvim')
      call dein#add('Shougo/neco-syntax')
      call dein#add('tbodt/deoplete-tabnine', {'build': './install.sh'})
      call dein#add('deoplete-plugins/deoplete-clang')
      call dein#add('Shougo/neoinclude.vim')
      call dein#add('Shougo/neco-vim', {'on_ft': 'vim'})
      call dein#add('deoplete-plugins/deoplete-zsh', {'on_ft': 'zsh'})
      call dein#add('deoplete-plugins/deoplete-dictionary')
      call dein#add('deoplete-plugins/deoplete-tag')

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
