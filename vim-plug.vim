"vim-plug loading {
  if !empty(glob('~/.local/share/nvim/site/autoload/plug.vim'))
    silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  endif
  call plug#begin('~/.local/share/nvim/plugged')

      "PY
      call Plug 'tweekmonster/braceless.vim', {'for': 'py', 'do': ':call plugins#_brace()'}

      "TEX
      call Plug 'lervag/vimtex', {'for': 'tex', 'do': 'call plugins#_tex()'}

      "AESTHETIC
      call Plug 'gvelchuru/gruvbox' "my version of the gruvbox colorscheme
      call Plug 'mhinz/vim-startify' "start screen
      call Plug 'vim-airline/vim-airline' "line prompt on bottom
      call Plug 'ryanoasis/vim-devicons' "nice icons
      call Plug 'tommcdo/vim-lion' "Alignment
      call Plug 'tpope/vim-sleuth' "heuristically set indent
      if has('pumblend')
        call Plug 'ncm2/float-preview.nvim' "show preview in floating window
      endif

      "TEXT OBJECTS
      call Plug 'tpope/vim-repeat'
      call Plug 'tpope/vim-unimpaired'

      "SEARCH
      call Plug 'nelstrom/vim-visual-star-search') "perform search on the current visual selection

      "SNIPPETS
      call Plug 'SirVer/ultisnips'
      call Plug 'honza/vim-snippets'

      "SEARCH
      call Plug 'junegunn/fzf', {'do': './install --all'}
      call Plug 'junegunn/fzf.vim'
      call Plug 'easymotion/vim-easymotion', {'on_map': '<Leader><Leader>'}

      "GIT
      call Plug 'tpope/vim-fugitive' "TODO: cmd
      call Plug 'tpope/vim-rhubarb'

      "SURROUND
      call Plug 'scrooloose/nerdcommenter', {'on_map': ['<Leader>cc', '<Leader>c<space>', '<Leader>cs']}
      call Plug 'tpope/vim-surround' "TODO: mappings
      call Plug 'wellle/targets.vim'
      call Plug 'michaeljsmith/vim-indent-object' "TODO: mappings

      "COMPLETION/LINTING
      call Plug 'dense-analysis/ale' 
      call Plug 'neoclide/coc.nvim', {'branch': 'release'}
      call Plug 'neoclide/coc-sources'
      call Plug 'neoclide/coc-neco'
      call Plug 'Shougo/neoinclude.vim'
      call Plug 'jsfaint/coc-neoinclude'

      "TAGS
      call Plug 'ludovicchabant/vim-gutentags'
      call Plug 'skywind3000/gutentags_plus'


      "GENERAL
      call Plug 'christoomey/vim-tmux-navigator'
      call Plug 'wakatime/vim-wakatime'
      call Plug 'tweekmonster/startuptime.vim', {'on': 'StartupTime'}

      "C
      call Plug 'justinmk/vim-syntax-extra', {'for': 'c'}

      "RESTORATION
      call Plug 'vim-scripts/restore_view.vim'

  call plug#end()
"}
