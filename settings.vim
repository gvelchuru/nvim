"Settings {
  set encoding=utf-8
  scriptencoding utf-8
  let mapleader = ','
  let maplocalleader = ','
  noremap \ ,
  set backspace=indent,eol,start
  set wildmode=longest,full
  set history=1000
  set ignorecase
  set smartcase
  set autoindent
  set showcmd
  set cmdheight=1
  set showmatch
  set incsearch
  set hlsearch

  set splitbelow
  set splitright
  set scrolljump=5
  set scrolloff=3
  set pastetoggle=<F12>

  set nobackup
  set nowritebackup
  set updatetime=300

  set undofile
  set undolevels=1000
  set undoreload=10000

  set viewoptions=cursor,folds,slash,unix

  set tabstop=4
  set softtabstop=0 noexpandtab
  set shiftwidth=4

  if has('pumblend')
    set pumblend=30
  endif
  set conceallevel=2 concealcursor=i

  set hidden
  set number
  set signcolumn=no
"}


"Remapping {
  noremap <C-]> <C-W><C-]>
  cnoremap sudow w !sudo tee % >/dev/null
  "expand active buffer path
  cnoremap <expr> %% getcmdtype() == ':' ? expand ('%:h').'/' : '%%'
  nnoremap <C-J> <C-W><C-J>
  nnoremap <C-K> <C-W><C-K>
  nnoremap <C-L> <C-W><C-L>
  nnoremap <C-H> <C-W><C-H>

  nnoremap & :&&<CR>
  xnoremap & :&&<CR>

  tnoremap <Esc> <C-\><C-n>

  " Navigate quickfix list with ease
  nnoremap <silent> [q :cprevious<CR>
  nnoremap <silent> ]q :cnext<CR>
"}

"Leader mapping {
  nnoremap <leader>a :argadd <c-r>=fnameescape(expand('%:p:h'))<cr>/*<C-d>
  nnoremap <leader>b :b <C-d>
  "nnoremap <leader>e :e **/
  nnoremap <Leader>g <cmd>Telescope live_grep<cr>
  nnoremap <leader>i :Ilist<space>
  nnoremap <leader>j :tjump /
  nnoremap <leader>m :make<cr>
  "nnoremap <leader>s :call StripTrailingWhitespace()<cr>
  "back to last buffer
  nnoremap <leader>q :b#<cr> 
  "nnoremap <leader>t :TTags<space>*<space>*<space>.<cr> need ttags
  map <Leader><Leader> <Plug>(easymotion-prefix)

"}
