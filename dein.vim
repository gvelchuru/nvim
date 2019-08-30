"Dein loading {
  if !empty(glob('/usr/share/vim/vimfiles/dein.vim'))
	  set runtimepath+=/usr/share/vim/vimfiles
  else
	set runtimepath+=~/.cache/dein/repos/github.com/Shougo/dein.vim
endif
  if dein#load_state('~/.cache/dein')
      call dein#begin('~/.cache/dein')

      "PY
      call dein#add('tweekmonster/braceless.vim', {'on_ft': 'py', 'hook_source': 'call plugins#_brace()'})

      "TEX
      call dein#add('lervag/vimtex', {'on_ft': 'tex', 'hook_source': 'call plugins#_tex()'})

      "AESTHETIC
      call dein#add('gvelchuru/gruvbox') "my version of the gruvbox colorscheme
      call dein#add('mhinz/vim-startify') "start screen
      call dein#add('vim-airline/vim-airline') "line prompt on bottom
      call dein#add('ryanoasis/vim-devicons') "nice icons
      call dein#add('tommcdo/vim-lion') "Alignment
      call dein#add('tpope/vim-sleuth') "heuristically set indent
      if has('pumblend')
        call dein#add('ncm2/float-preview.nvim') "show preview in floating window
      endif

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

      "GIT
      call dein#add('tpope/vim-fugitive') "TODO: cmd
      call dein#add('tpope/vim-rhubarb')

      "SURROUND
      call dein#add('scrooloose/nerdcommenter', {'on_map': ['<Leader>cc', '<Leader>c<space>', '<Leader>cs']})
      call dein#add('tpope/vim-surround') "TODO: mappings
      call dein#add('wellle/targets.vim')
      call dein#add('michaeljsmith/vim-indent-object') "TODO: mappings

      "COMPLETION/LINTING
      call dein#add('dense-analysis/ale') "TODO: LSP functions
      call dein#add('neoclide/coc.nvim' ,{'rev': 'release'})
      call dein#add('neoclide/coc-sources')
      call dein#add('neoclide/coc-neco')
      call dein#add('Shougo/neoinclude.vim')
      call dein#add('jsfaint/coc-neoinclude')

      "TAGS
      call dein#add('ludovicchabant/vim-gutentags')
      call dein#add('skywind3000/gutentags_plus')


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
