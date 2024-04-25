"Settings {
  set encoding=utf-8
  scriptencoding utf-8
  let mapleader = ','
  let maplocalleader = ','
  noremap \ ,
  set backspace=indent,eol,start
  set wildmode=longest,full
  set ignorecase
  set smartcase
  set showmatch
  set incsearch
  set hlsearch

  set splitbelow
  set splitright

  set viewoptions=cursor,folds,slash,unix
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
  nnoremap <C-N> :CHADopen<CR>

  nnoremap & :&&<CR>
  xnoremap & :&&<CR>

  tnoremap <Esc> <C-\><C-n>

  " Navigate quickfix list with ease
  nnoremap <silent> [q :cprevious<CR>
  nnoremap <silent> ]q :cnext<CR>
"}

"Leader mapping {
  nnoremap <Leader>g <cmd>Telescope live_grep<cr>
  nnoremap <leader>i :Ilist<space>
"}
