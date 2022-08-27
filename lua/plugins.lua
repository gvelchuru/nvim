local fn = vim.fn
local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'
if fn.empty(fn.glob(install_path)) > 0 then
  packer_bootstrap = fn.system({'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path})
  vim.cmd [[packadd packer.nvim]]
end

vim.cmd([[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost plugins.lua source <afile> | PackerCompile
  augroup end
]])

return require('packer').startup(function(use)
  use 'wbthomason/packer.nvim'
  -- PY
  use { 'tweekmonster/braceless.vim', ft = 'py', run = function() vim.fn['call plugins#_brace'](0) end }

  --TEX
  use { 'lervag/vimtex', ft = 'tex', run = function() vim.fn['call plugins#_tex'](0) end  } 

  --AESTHETIC
    use { 'altercation/vim-colors-solarized' }
    use { 'nvim-lualine/lualine.nvim', requires = { 'kyazdani42/nvim-web-devicons', opt = true } }
    use { 'tommcdo/vim-lion', keys = {'gl', 'gL'} }
    use { 'tpope/vim-sleuth' } --heuristically set indent
    use { 'sheerun/vim-polyglot' }
    use { 'ncm2/float-preview.nvim' }
    use { 'nvim-treesitter/nvim-treesitter', cmd = 'TSUpdate' }
    use { 'kyazdani42/nvim-web-devicons' }

  --TEXT OBJECTS
    use { 'tpope/vim-repeat', keys = '.' }
    use { 'tpope/vim-unimpaired' }
	use { 'nelstrom/vim-visual-star-search', keys = {'*', '#'} }

--SNIPPETS
	use { 'SirVer/ultisnips' }
	use { 'honza/vim-snippets' }

--SEARCH
	use { 'easymotion/vim-easymotion' }
	use { 'nvim-telescope/telescope.nvim', requires = { 'nvim-lua/plenary.nvim', 'nvim-telescope/telescope-fzy-native.nvim', 'fannheyward/telescope-coc.nvim'} }

	use { 'preservim/nerdtree', cmd = {'NERDTree', 'NERDTreeToggle'} }

--GIT
	use { 'tpope/vim-fugitive' }
	use { 'tpope/vim-rhubarb' }

--SURROUND
	use { 'scrooloose/nerdcommenter' }
	use { 'tpope/vim-surround' }
	use { 'wellle/targets.vim' }
	use { 'michaeljsmith/vim-indent-object' }

--COMPLETION/LINTING
	use { 'dense-analysis/ale' }
	use { 'Shougo/neoinclude.vim' }
	use { 'neoclide/coc.nvim', branch = 'release', requires = {'neoclide/coc-sources', 'neoclide/coc-neco', 'jsfaint/coc-neoinclude'} }

--TAGS
    use { 'ludovicchabant/vim-gutentags', ft = {'c', 'cpp' } }
	use { 'skywind3000/gutentags_plus', ft = {'c', 'cpp' }}
	
--SPLITTING
	use { 'christoomey/vim-tmux-navigator' }
	use { 'camspiers/lens.vim' }

--GENERAL
	use { 'tweekmonster/startuptime.vim', cmd = 'StartupTime' }
	use { 'rizzatti/dash.vim' }
--C
	use { 'vim-scripts/a.vim', ft = {'c', 'cpp'} }
	use { 'chrisbra/csv.vim' }
--RESTORATION
	use { 'vim-scripts/restore_view.vim' }
	

  -- Automatically set up your configuration after cloning packer.nvim
  -- Put this at the end after all plugins
  if packer_bootstrap then
    require('packer').sync()
  end
end)
