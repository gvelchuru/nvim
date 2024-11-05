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
	spec = {
		-- import your plugins
		{ import = "plugins" },
		--AESTHETIC
		{
			"nvim-lualine/lualine.nvim",
			lazy = true,
			dependencies = { "kyazdani42/nvim-web-devicons" },
		},
		{ "catppuccin/nvim", name = "catppuccin", priority = 1000, lazy = false },
		{ "tpope/vim-sleuth" }, --heuristically set indent
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
		{ "bekaboo/dropbar.nvim", lazy = false },
		{ "HiPhish/rainbow-delimiters.nvim" },
		{ "RRethy/vim-illuminate", lazy = true },
		{
			"goolord/alpha-nvim",
			dependencies = { "echasnovski/mini.icons" },
			config = function()
				require("alpha").setup(require("alpha.themes.startify").config)
			end,
		},
		{ "mistricky/codesnap.nvim", build = "make" },

		--TEXT OBJECTS
		{ "tpope/vim-repeat", keys = "." },
		{ "tpope/vim-unimpaired" },
		{ "nelstrom/vim-visual-star-search", lazy = true, keys = { "*", "#" } },
		{
			"tris203/precognition.nvim",
			event = "VeryLazy",
			opts = {
				startVisible = false,
				-- showBlankVirtLine = true,
				-- highlightColor = { link = "Comment" },
				-- hints = {
				--      Caret = { text = "^", prio = 2 },
				--      Dollar = { text = "$", prio = 1 },
				--      MatchingPair = { text = "%", prio = 5 },
				--      Zero = { text = "0", prio = 1 },
				--      w = { text = "w", prio = 10 },
				--      b = { text = "b", prio = 9 },
				--      e = { text = "e", prio = 8 },
				--      W = { text = "W", prio = 7 },
				--      B = { text = "B", prio = 6 },
				--      E = { text = "E", prio = 5 },
				-- },
				-- gutterHints = {
				--     G = { text = "G", prio = 10 },
				--     gg = { text = "gg", prio = 9 },
				--     PrevParagraph = { text = "{", prio = 8 },
				--     NextParagraph = { text = "}", prio = 8 },
				-- },
				-- disabled_fts = {
				--     "startify",
				-- },
			},
		},

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
			lazy = true,
		},
		{
			"danielfalk/smart-open.nvim",
			branch = "0.2.x",
			config = function()
				require("telescope").load_extension("smart_open")
			end,
			dependencies = {
				"kkharji/sqlite.lua",
				-- Only required if using match_algorithm fzf
				{ "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
				-- Optional.  If installed, native fzy will be used when match_algorithm is fzy
				{ "nvim-telescope/telescope-fzy-native.nvim" },
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
			lazy = true,
			dependencies = {
				"neovim/nvim-lspconfig",
				"hrsh7th/cmp-nvim-lsp",
				"hrsh7th/cmp-nvim-lsp-document-symbol",
				"hrsh7th/cmp-nvim-lsp-signature-help",
				"hrsh7th/cmp-buffer",
				"hrsh7th/cmp-path",
				"hrsh7th/cmp-cmdline",
				"L3MON4D3/LuaSnip",
				"saadparwaiz1/cmp_luasnip",
				"petertriho/cmp-git",
				"onsails/lspkind.nvim",
				"zbirenbaum/copilot-cmp",
				"lukas-reineke/cmp-rg",
				"tzachar/fuzzy.nvim",
			},
		},
		{ "tzachar/fuzzy.nvim", dependencies = { "nvim-lua/plenary.nvim" } },
		{ "tzachar/cmp-fuzzy-buffer", requires = { "hrsh7th/nvim-cmp", "tzachar/fuzzy.nvim" } },
		{ "tzachar/cmp-fuzzy-path", requires = { "hrsh7th/nvim-cmp", "tzachar/fuzzy.nvim" } },
		{ "romgrk/fzy-lua-native", build = "make" },
		{ "petertriho/cmp-git", dependencies = { "nvim-lua/plenary.nvim" } },
		{
			"folke/trouble.nvim",
			requires = {
				"kyazdani42/nvim-web-devicons",
			},
			lazy = false,
		},
		{ "williamboman/mason.nvim" },
		{ "rshkarin/mason-nvim-lint" },
		{ "williamboman/mason-lspconfig.nvim" },
		{ "mfussenegger/nvim-lint" },

		--SPLITTING
		{ "nvim-focus/focus.nvim", version = false },

		--GENERAL
		--{
		--	"pocco81/auto-save.nvim",
		--},
		{
			"zbirenbaum/copilot-cmp",
			dependencies = { "zbirenbaum/copilot.lua" },
			config = function()
				require("copilot_cmp").setup()
			end,
		},
		{
			"zbirenbaum/copilot.lua",
			config = function()
				require("copilot").setup({
					filetypes = { ["*"] = true },
					suggestion = { enabled = false },
					panel = { enabled = false },
				})
			end,
		},
		{
			"kevinhwang91/nvim-fundo",
			dependencies = "kevinhwang91/promise-async",
			config = function()
				require("fundo").install()
			end,
		},
		{
			"oysandvik94/curl.nvim",
			cmd = { "CurlOpen" },
			dependencies = {
				"nvim-lua/plenary.nvim",
			},
			config = true,
		},

		--C
		{ "chrisbra/csv.vim" },

		--SESSIONS
		--{
		--"rmagatti/auto-session",
		--config = function()
		--require("auto-session").setup({
		--	log_level = "error",
		--})
		--end,
		--},

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
		{ "gelguy/wilder.nvim" },
		{ "dstein64/vim-startuptime" },
	},
	install = { colorscheme = { "catppuccin-frappe" } },
	  -- automatically check for plugin updates
	  checker = { enabled = true },
})
