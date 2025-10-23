vim.g.loaded = 1
vim.g.loaded_netrwPlugin = 1
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
require("trouble").setup()
vim.keymap.set("n", "gR", function()
  require("trouble").toggle("lsp_references")
end)
require("Comment").setup()
-- Explicit leap.nvim keymaps (avoids conflict warnings with cutlass)
vim.keymap.set({ "n", "x", "o" }, "s", "<Plug>(leap-forward)", { silent = true })
vim.keymap.set({ "n", "x", "o" }, "S", "<Plug>(leap-backward)", { silent = true })
require("focus").setup()
-- CMP setup moved to lazy.nvim config with InsertEnter event

-- Set up lspconfig.
local capabilities = require("cmp_nvim_lsp").default_capabilities()

local function on_attach(_, bufnr)
  local bufopts = { buffer = bufnr }
  vim.keymap.set("n", "gd", vim.lsp.buf.definition, bufopts)
  vim.keymap.set("n", "<LEADER>k", vim.lsp.buf.hover, bufopts)
  vim.keymap.set("n", "<LEADER>r", vim.lsp.buf.rename, bufopts)
  vim.keymap.set("n", "<LEADER>a", vim.lsp.buf.code_action, bufopts)
  vim.keymap.set("v", "<LEADER>a", vim.lsp.buf.code_action, bufopts)
end

local lsp_opts = {
  capabilities = capabilities,
  on_attach = on_attach,
}
local lspconfig = require("lspconfig")

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

require("mason-nvim-lint").setup()

require("lint").linters_by_ft = {
  markdown = { "vale" },
  ruby = { "rubocop", "trivy" },
}
vim.api.nvim_create_autocmd({ "BufWritePost" }, {
  callback = function()
    require("lint").try_lint()
  end,
})
-- Catppuccin, wilder, and toggleterm setups moved to lazy.nvim configs

vim.keymap.set("n", "<c-n>", function()
  require("focus").split_nicely()
end, { desc = "split nicely" })
require("codesnap").setup({
  has_line_number = true,
  has_breadcrumbs = true,
})
