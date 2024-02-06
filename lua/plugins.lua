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
	-- PY
	{
		"tweekmonster/braceless.vim",
		ft = "py",
		lazy = true,
		build = function()
			vim.fn["call plugins#_brace"](0)
		end,
	},

	--TEX
	{
		"lervag/vimtex",
		ft = "tex",
		lazy = true,
		build = function()
			vim.fn["call plugins#_tex"](0)
		end,
	},

	--PLANTUML
	{
		"weirongxu/plantuml-previewer.vim",
		lazy = true,
		requires = {
			"tyru/open-browser.vim",
			"aklt/plantuml-syntax",
		},
	},

	--AESTHETIC
	{
		"nvim-lualine/lualine.nvim",
		lazy = true,
		dependencies = { "kyazdani42/nvim-web-devicons" },
	},
	{ "catppuccin/nvim", name = "catppuccin", priority = 1000 },
	{ "tommcdo/vim-lion", lazy = true, keys = { "gl", "gL" } },
	{ "tpope/vim-sleuth" }, --heuristically set indent
	{ "ncm2/float-preview.nvim" },
	{
		"nvim-treesitter/nvim-treesitter",
		lazy = true,
		build = ":TSUpdate",
	},
	{
		"ms-jpq/chadtree",
		branch = "chad",
		lazy = true,
		build = ":CHADdeps",
	},
	--{ "gelguy/wilder.nvim" }, --doesn't work with nui
	{ "hiphish/rainbow-delimiters.nvim", lazy = true },
	{ "bekaboo/dropbar.nvim", lazy = false },
	{ "RRethy/vim-illuminate", lazy = true },
	{
		"nvimdev/dashboard-nvim",
		event = "VimEnter",
		config = function()
			require("dashboard").setup({
				-- config
			})
		end,
		dependencies = { { "nvim-tree/nvim-web-devicons" } },
	},
	{
		"luukvbaal/statuscol.nvim",
		config = function()
			-- local builtin = require("statuscol.builtin")
			require("statuscol").setup({
				-- configuration goes here, for example:
				-- relculright = true,
				-- segments = {
				--   { text = { builtin.foldfunc }, click = "v:lua.ScFa" },
				--   {
				--     sign = { name = { "Diagnostic" }, maxwidth = 2, auto = true },
				--     click = "v:lua.ScSa"
				--   },
				--   { text = { builtin.lnumfunc }, click = "v:lua.ScLa", },
				--   {
				--     sign = { name = { ".*" }, maxwidth = 2, colwidth = 1, auto = true, wrap = true },
				--     click = "v:lua.ScSa"
				--   },
				-- }
			})
		end,
		lazy = false,
	},

	--TEXT OBJECTS
	{ "tpope/vim-repeat", keys = "." },
	{ "tpope/vim-unimpaired" },
	{ "nelstrom/vim-visual-star-search", lazy = true, keys = { "*", "#" } },

	--SNIPPETS
	{ "SirVer/ultisnips" },
	{ "honza/vim-snippets" },

	--SEARCH
	{ "ggandor/leap.nvim" },
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
		dependencies = { "tpope/vim-fugitive", "folke/trouble.nvim" },
	},

	--SURROUND
	{
		"numToStr/Comment.nvim",
		opts = {
			-- add any options here
		},
	},
	{ "tpope/vim-surround" },
	{ "wellle/targets.vim" },
	{ "michaeljsmith/vim-indent-object" },

	--COMPLETION/LINTING
	{ "dense-analysis/ale", lazy = false },
	{
		"folke/trouble.nvim",
		requires = {
			"kyazdani42/nvim-web-devicons",
			"folke/lsp-colors.nvim",
		},
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
		lazy = false,
	},
	{ "Shougo/neoinclude.vim" },
	{
		"neoclide/coc.nvim",
		branch = "release",
		dependencies = {
			"neoclide/coc-sources",
			"neoclide/coc-neco",
			"jsfaint/coc-neoinclude",
		},
		lazy = false,
	},

	--SPLITTING
	{ "nvim-focus/focus.nvim", version = false },

	--GENERAL
	{ "rizzatti/dash.vim" },
	{ "github/copilot.vim" },

	--C
	{ "chrisbra/csv.vim" },

	--SESSIONS
	{
		"rmagatti/auto-session",
		config = function()
			require("auto-session").setup({
				log_level = "error",
			})
		end,
	},

	--NOTIFICATIONS
	{
		"folke/noice.nvim",
		opts = {
			-- add any options here
		},
		dependencies = {
			"MunifTanjim/nui.nvim",
			"rcarriga/nvim-notify",
		},
	},
})
