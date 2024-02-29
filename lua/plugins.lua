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
	--AESTHETIC
	{
		"nvim-lualine/lualine.nvim",
		lazy = true,
		dependencies = { "kyazdani42/nvim-web-devicons" },
	},
	{ "folke/tokyonight.nvim", priority = 1000, lazy = false },
	{ "tommcdo/vim-lion", lazy = true, keys = { "gl", "gL" } },
	{ "tpope/vim-sleuth" }, --heuristically set indent
	--{ "ncm2/float-preview.nvim" },
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
		dependencies = {  "nvim-tree/nvim-web-devicons"  },
	},

	--TEXT OBJECTS
	{ "tpope/vim-repeat", keys = "." },
	{ "tpope/vim-unimpaired" },
	{ "nelstrom/vim-visual-star-search", lazy = true, keys = { "*", "#" } },

	--SNIPPETS
	{
		"L3MON4D3/LuaSnip",
		-- follow latest release.
		version = "v2.*", -- Replace <CurrentMajor> by the latest released major (first number of latest release)
		-- install jsregexp (optional!).
		build = "make install_jsregexp",
	},

	--SEARCH
	{ "ggandor/leap.nvim" },
	{
		"nvim-telescope/telescope.nvim",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"nvim-telescope/telescope-fzy-native.nvim",
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
				signcolumn = true,
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
	--{ "tpope/vim-surround" },
	{ "wellle/targets.vim" },
	{ "michaeljsmith/vim-indent-object" },

	--COMPLETION/LINTING
	{
		"hrsh7th/nvim-cmp",
		lazy = false,
		dependencies = {
			"neovim/nvim-lspconfig",
			"hrsh7th/cmp-nvim-lsp",
			"hrsh7th/cmp-buffer",
			"hrsh7th/cmp-path",
			"hrsh7th/cmp-cmdline",
			"L3MON4D3/LuaSnip",
			'saadparwaiz1/cmp_luasnip',
			"petertriho/cmp-git",
			"onsails/lspkind.nvim",
			"zbirenbaum/copilot-cmp"
		},
	},
	{ "petertriho/cmp-git", dependencies = {"nvim-lua/plenary.nvim"}},
	{
		"folke/trouble.nvim",
		requires = {
			"kyazdani42/nvim-web-devicons",
			"folke/lsp-colors.nvim",
		},
		opts = {
			signs = {
				-- icons / text used for a diagnostic
				error = "",
				warning = "",
				hint = "",
				information = "",
				other = "",
			},
			use_diagnostic_signs = false
		},
		lazy = false,
	},
	{"williamboman/mason.nvim"},
	{"williamboman/mason-lspconfig.nvim"},
	{ 'nvimtools/none-ls.nvim', name = "null-ls", dependencies = {"nvim-lua/plenary.nvim"}},

	--SPLITTING
	{ "nvim-focus/focus.nvim", version = false },

	--GENERAL
	{ "rizzatti/dash.vim" },
	{
	  "zbirenbaum/copilot-cmp",
		dependencies = {'zbirenbaum/copilot.lua'},
	  config = function ()
		require("copilot_cmp").setup()
	  end
	},
	{
		"zbirenbaum/copilot.lua",
		config = function ()
		  require("copilot").setup({
			filetypes = { ["*"] = true },
			suggestion = { enabled = false },
			panel = { enabled = false },
		  })
		end
	},

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
