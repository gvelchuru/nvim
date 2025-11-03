vim.g.loaded = 1
vim.g.loaded_netrwPlugin = 1

-- Set leader key to space (must be before lazy.nvim)
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Reduce LSP logging overhead (was causing 800MB log file)
vim.lsp.log.set_level("WARN") -- Fixed deprecated API

-- Native smooth scrolling (Neovim 0.10+, replaces neoscroll.nvim)
vim.opt.smoothscroll = true

require("config.lazy")
vim.cmd("set number")
vim.cmd("set signcolumn=number")
vim.cmd("set ignorecase")
vim.cmd("set smartcase")
vim.cmd("set showmatch")
vim.cmd("set incsearch")
vim.cmd("set hlsearch")
vim.cmd("set wildmenu")
vim.cmd("syntax enable")
vim.env.NVIM_TUI_ENABLE_TRUE_COLOR = 1
vim.opt.termguicolors = true
-- Treesitter setup moved to lazy.nvim config
-- Telescope setup moved to lazy.nvim config with key-based lazy loading
-- Trouble, Comment, Focus setups moved to lazy.nvim config with lazy loading
-- Explicit leap.nvim keymaps (avoids conflict warnings with cutlass)
vim.keymap.set({ "n", "x", "o" }, "s", "<Plug>(leap-forward)", { silent = true })
vim.keymap.set({ "n", "x", "o" }, "S", "<Plug>(leap-backward)", { silent = true })
-- CMP setup moved to lazy.nvim config with InsertEnter event
-- LSP setup moved to mason-lspconfig in lazy.nvim config

-- Lualine setup moved to lazy.nvim config with VeryLazy event

vim.g["NERDCompactSexyComs"] = 1
-- Telescope keymaps moved to lazy.nvim config
vim.keymap.set("n", "<C-J>", "<C-W><C-J>")
vim.keymap.set("n", "<C-K>", "<C-W><C-K>")
vim.keymap.set("n", "<C-L>", "<C-W><C-L>")
vim.keymap.set("n", "<C-H>", "<C-W><C-H>")
vim.cmd("sign define DiagnosticSignError text= texthl=DiagnosticSignError linehl= numhl=")
vim.cmd("sign define DiagnosticSignWarn text= texthl= linehl= numhl=")
vim.cmd("sign define DiagnosticSignInfo text= texthl= linehl= numhl=")
vim.cmd("sign define DiagnosticSignHint text= texthl= linehl= numhl=")
-- Fundo setup moved to lazy.nvim config with BufReadPost event
-- Mason-nvim-lint, lint, codesnap setups moved to lazy.nvim configs with lazy loading
-- Catppuccin, wilder, and toggleterm setups moved to lazy.nvim configs
