"vim-plug loading {
  if empty(glob('~/.local/share/nvim/site/autoload/plug.vim'))
    silent !curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs
    	\ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  endif
  call plug#begin('~/.local/share/nvim/plugged')

      "PY
      Plug 'tweekmonster/braceless.vim', {'for': 'py', 'do': ':call plugins#_brace()'}

      "TEX
      Plug 'lervag/vimtex', {'for': 'tex', 'do': 'call plugins#_tex()'}

      "AESTHETIC
      Plug 'gvelchuru/gruvbox' "my version of the gruvbox colorscheme
      Plug 'mhinz/vim-startify' "start screen
      Plug 'vim-airline/vim-airline' "line prompt on bottom
      Plug 'ryanoasis/vim-devicons' "nice icons
      Plug 'tommcdo/vim-lion' "Alignment
      Plug 'tpope/vim-sleuth' "heuristically set indent
      if has('pumblend')
        Plug 'ncm2/float-preview.nvim' "show preview in floating window
      endif

      "TEXT OBJECTS
      Plug 'tpope/vim-repeat'
      Plug 'tpope/vim-unimpaired'

      "SEARCH
      Plug 'nelstrom/vim-visual-star-search' "perform search on the current visual selection

      "SNIPPETS
      Plug 'SirVer/ultisnips'
      Plug 'honza/vim-snippets'

      "SEARCH
      Plug 'junegunn/fzf', {'do': './install --all'}
      Plug 'junegunn/fzf.vim'
      Plug 'easymotion/vim-easymotion', {'on_map': '<Leader><Leader>'}

      "GIT
      Plug 'tpope/vim-fugitive' "TODO: cmd
      Plug 'tpope/vim-rhubarb'

      "SURROUND
      Plug 'scrooloose/nerdcommenter', {'on_map': ['<Leader>cc', '<Leader>c<space>', '<Leader>cs']}
      Plug 'tpope/vim-surround' "TODO: mappings
      Plug 'wellle/targets.vim'
      Plug 'michaeljsmith/vim-indent-object' "TODO: mappings

      "COMPLETION/LINTING
      Plug 'dense-analysis/ale' 
      Plug 'neoclide/coc.nvim', {'branch': 'release'}
      Plug 'neoclide/coc-sources'
      Plug 'neoclide/coc-neco'
      Plug 'Shougo/neoinclude.vim'
      Plug 'jsfaint/coc-neoinclude'

      "TAGS
      Plug 'ludovicchabant/vim-gutentags'
      Plug 'skywind3000/gutentags_plus'


      "GENERAL
      Plug 'christoomey/vim-tmux-navigator'
      Plug 'wakatime/vim-wakatime'
      Plug 'tweekmonster/startuptime.vim', {'on': 'StartupTime'}

      "C
      Plug 'justinmk/vim-syntax-extra', {'for': 'c'}

      "RESTORATION
      Plug 'vim-scripts/restore_view.vim'

  call plug#end()
"}
