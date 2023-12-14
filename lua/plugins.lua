local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"https://github.com/folke/lazy.nvim.git",
		"--branch=stable", -- latest stable release
		lazypath,
	})
end
vim.opt.rtp:prepend(lazypath)

return require("lazy").setup({
	"wbthomason/packer.nvim",
	-- PY
	{
		"tweekmonster/braceless.vim",
		ft = "py",
		build = function()
			vim.fn["call plugins#_brace"](0)
		end,
	},

	--TEX
	{
		"lervag/vimtex",
		ft = "tex",
		build = function()
			vim.fn["call plugins#_tex"](0)
		end,
	},

	--PLANTUML
	{ "weirongxu/plantuml-previewer.vim", requires = { "tyru/open-browser.vim", "aklt/plantuml-syntax" } },
	--use { 'scrooloose/vim-slumlord', requires = 'aklt/plantuml-syntax'  }

	--AESTHETIC
	{ "nvim-lualine/lualine.nvim", dependencies = { "kyazdani42/nvim-web-devicons", lazy = true } },
	--      {
	--   "utilyre/barbecue.nvim",
	--   name = "barbecue",
	--   version = "*",
	--   dependencies = {
	--     "SmiteshP/nvim-navic",
	--     "nvim-tree/nvim-web-devicons", -- optional dependency
	--   },
	--   opts = {
	--     -- configurations go here
	--   },
	-- },
	--
	--{'altercation/vim-colors-solarized'},
	{
	"folke/tokyonight.nvim",
	lazy = false, -- make sure we load this during startup if it is your main colorscheme
	priority = 1000, -- make sure to load this before all the other start plugins
	config = function()
	require('tokyonight').setup({
	style='night'})
	end,
	},
	{ "tommcdo/vim-lion", keys = { "gl", "gL" } },
	{ "tpope/vim-sleuth" }, --heuristically set indent
	{ "ncm2/float-preview.nvim" },
	{ "nvim-treesitter/nvim-treesitter", build = ":TSUpdate" },
	{ "ms-jpq/chadtree", branch = "chad", build = ":CHADdeps" },
	{ "gelguy/wilder.nvim" },
	{ "hiphish/rainbow-delimiters.nvim" },

	--TEXT OBJECTS
	{ "tpope/vim-repeat", keys = "." },
	{ "tpope/vim-unimpaired" },
	{ "nelstrom/vim-visual-star-search", keys = { "*", "#" } },

	--SNIPPETS
	{ "SirVer/ultisnips" },
	{ "honza/vim-snippets" },

	--SEARCH
	{ "easymotion/vim-easymotion" },
	{
		"nvim-telescope/telescope.nvim",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"nvim-telescope/telescope-fzy-native.nvim",
			"fannheyward/telescope-coc.nvim",
		},
	},

	--GIT
	{ "tpope/vim-fugitive" },
	{ "tpope/vim-rhubarb" },
	{
		"lewis6991/gitsigns.nvim",
		config = function()
			require("gitsigns").setup({
				current_line_blame = true,
				signcolumn = false,
			})
		end,
	},

	--SURROUND
	--{ 'scrooloose/nerdcommenter' },
	{
		"numToStr/Comment.nvim",
		opts = {
			-- add any options here
		},
		lazy = false,
	},
	{ "tpope/vim-surround" },
	{ "wellle/targets.vim" },
	{ "michaeljsmith/vim-indent-object" },

	--COMPLETION/LINTING
	{ "dense-analysis/ale" },
	{
		"folke/trouble.nvim",
		requires = { "kyazdani42/nvim-web-devicons", "folke/lsp-colors.nvim" },
		config = function()
			require("trouble").setup({
				--[[signs = {
			   [-- icons / text used for a diagnostic
			   [error = "error",
			   [warning = "warn",
			   [hint = "hint",
			   [information = "info"
			   [},
			   [use_diagnostic_signs = true]]
			})
		end,
	},
	{ "Shougo/neoinclude.vim" },
	{
		"neoclide/coc.nvim",
		branch = "release",
		dependencies = { "neoclide/coc-sources", "neoclide/coc-neco", "jsfaint/coc-neoinclude" },
	},
	--use { 'beeender/Comrade' }

	--TAGS
	{ "ludovicchabant/vim-gutentags", ft = { "c", "cpp" } },
	{ "skywind3000/gutentags_plus", ft = { "c", "cpp" } },

	--SPLITTING
	{ "christoomey/vim-tmux-navigator" },
	{ "camspiers/lens.vim" },

	--GENERAL
	{ "rizzatti/dash.vim" },
	{ "thalesmello/lkml.vim" },
	{ "github/copilot.vim" },

	--C
	{ "vim-scripts/a.vim", ft = { "c", "cpp" } },
	{ "chrisbra/csv.vim" },
	--RESTORATION
	{ "vim-scripts/restore_view.vim" },
})
