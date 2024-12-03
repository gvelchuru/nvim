vim.g.loaded = 1
vim.g.loaded_netrwPlugin = 1
require('config.lazy')
vim.cmd('set number')
vim.cmd('set signcolumn=number')
vim.cmd('set ignorecase')
vim.cmd('set smartcase')
vim.cmd('set showmatch')
vim.cmd('set incsearch')
vim.cmd('set hlsearch')
vim.cmd('set wildmenu')
vim.cmd('syntax enable')
vim.env.NVIM_TUI_ENABLE_TRUE_COLOR=1
vim.opt.termguicolors=true
vim.opt.background="dark"
vim.cmd[[colorscheme catppuccin-macchiato]]
require'nvim-treesitter.configs'.setup {
  ensure_installed = {"c", "lua", "vim", "vimdoc", "query", "go", "ruby", "yaml"},

  -- Install parsers synchronously (only applied to `ensure_installed`)
  sync_install = true,

  -- Automatically install missing parsers when entering buffer
  -- Recommendation: set to false if you don't have `tree-sitter` CLI installed locally
  auto_install = true,

  highlight = {
    enable = true,

    -- Setting this to true will run `:h syntax` and tree-sitter at the same time.
    -- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
    -- Using this option may slow down your editor, and you may see some duplicate highlights.
    -- Instead of true it can also be a list of languages
    additional_vim_regex_highlighting = true,
  },
}
require("trouble").setup()
vim.keymap.set("n", "gR", function() require("trouble").toggle("lsp_references") end)
local actions = require("telescope.actions")
local trouble = require("trouble.sources.telescope")
require('telescope').setup {
    extensions = {
        fzy_native = {
            override_generic_sorter = true,
            override_file_sorter = true, },
    },
    pickers = {
                --live_grep = {
                 --   file_ignore_patterns = { 'node_modules', '.git', '.venv' },
                  --  additional_args = function(_)
                   --     return { "--hidden" }
                    --end
                --},
                find_files = {
                    find_command = { "rg", "--files", "--hidden", "--glob", "!**/.git/*", "--glob", "!node_modules/*" },
                }

            },
    defaults = {
        mappings = {
          i = { ["<c-t>"] = trouble.open },
          n = { ["<c-t>"] = trouble.open },
        },
  },
}
require('telescope').load_extension('fzy_native')
require("telescope").load_extension("noice")
--require("barbecue.ui").toggle(true)
require('Comment').setup()
require('leap').create_default_mappings()
require("focus").setup()
require("cmp_git").setup()
local lspkind = require'lspkind'
local cmp = require'cmp'
cmp.setup({
  snippet = {
    expand = function(args)
      require('luasnip').lsp_expand(args.body)
    end,
  },
  window = {
    -- completion = cmp.config.window.bordered(),
    -- documentation = cmp.config.window.bordered(),
  },
  mapping = cmp.mapping.preset.insert({
    ['<C-b>'] = cmp.mapping.scroll_docs(-4),
    ['<C-f>'] = cmp.mapping.scroll_docs(4),
    ['<C-Space>'] = cmp.mapping.complete(),
    ['<C-e>'] = cmp.mapping.abort(),
    ['<CR>'] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
  }),
  sources = cmp.config.sources({
    { name = 'nvim_lsp_document_symbol'},
    { name = 'nvim_lsp_signature_help'},
    { name = 'luasnip'},
    { name = 'git'},
    { name = 'copilot'},
    { name = 'fuzzy_buffer'},
    { name = 'fuzzy_path'},
    { name = 'rg'}
  }),
  formatting = {
  format = lspkind.cmp_format({
    mode = 'symbol', -- show only symbol annotations
    maxwidth = 50, -- prevent the popup from showing more than provided characters (e.g 50 will not show more than 50 characters)
                   -- can also be a function to dynamically calculate max width such as 
                   -- maxwidth = function() return math.floor(0.45 * vim.o.columns) end,
    ellipsis_char = '...', -- when popup menu exceed maxwidth, the truncated part would show ellipsis_char instead (must define maxwidth first)
    show_labelDetails = true, -- show labelDetails in menu. Disabled by default
  })
}
})

-- Use buffer source for `/` and `?` (if you enabled `native_menu`, this won't work anymore).
cmp.setup.cmdline({ '/', '?' }, {
  mapping = cmp.mapping.preset.cmdline(),
  sources = {
    { name = 'buffer' }
  }
})

-- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
cmp.setup.cmdline(':', {
  mapping = cmp.mapping.preset.cmdline(),
  sources = cmp.config.sources({
    { name = 'path' }
  }, {
    { name = 'cmdline' }
  })
})
 



-- Set up lspconfig.
local capabilities = require('cmp_nvim_lsp').default_capabilities()

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
   on_attach = on_attach
 }
local lspconfig = require("lspconfig")
require("mason").setup()
require("mason-lspconfig").setup({
  ensure_installed = { "lua_ls", "rubocop", "solargraph" },
  automatic_installation = true
})
require("mason-lspconfig").setup_handlers {
    function (server_name) -- default handler (optional)
        require("lspconfig")[server_name].setup {}
    end,
}


require('lualine').setup {
    options = {
        theme = 'auto',
        component_separators = '',
        section_separators = '',
    },
    extensions = {'trouble', 'lazy', 'fzf', 'quickfix'},
}
require('lualine').get_config()

vim.g['NERDCompactSexyComs'] = 1
vim.keymap.set('n', '<C-P>', '<cmd>Telescope find_files<cr>')
vim.keymap.set('n', '<C-J>', '<C-W><C-J>')
vim.keymap.set('n', '<C-K>', '<C-W><C-K>')
vim.keymap.set('n', '<C-L>', '<C-W><C-L>')
vim.keymap.set('n', '<C-H>', '<C-W><C-H>')
vim.keymap.set('n', '<C-H>', '<C-W><C-H>')
vim.keymap.set('n', '<Leader>g', '<cmd>Telescope live_grep<cr>')
vim.cmd('sign define DiagnosticSignError text= texthl=DiagnosticSignError linehl= numhl=')
vim.cmd('sign define DiagnosticSignWarn text= texthl= linehl= numhl=')
vim.cmd('sign define DiagnosticSignInfo text= texthl= linehl= numhl=')
vim.cmd('sign define DiagnosticSignHint text= texthl= linehl= numhl=')
vim.o.undofile = true
require('fundo').setup()

require("mason-nvim-lint").setup()

require('lint').linters_by_ft = {
  markdown = {'vale',},
  ruby = {'rubocop', 'trivy'},
}
vim.api.nvim_create_autocmd({"BufWritePost" }, {
  callback = function()
    require("lint").try_lint()
  end,
})
--require("noice").setup({
 -- lsp = {
    -- override markdown rendering so that **cmp** and other plugins use **Treesitter**
  --  override = {
   --   ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
    --  ["vim.lsp.util.stylize_markdown"] = true,
     -- ["cmp.entry.get_documentation"] = true, -- requires hrsh7th/nvim-cmp
   -- },
  --},
  -- you can enable a preset for easier configuration
  --presets = {
    --command_palette = false, -- position the cmdline and popupmenu together
    --long_message_to_split = true, -- long messages will be sent to a split
    --inc_rename = false, -- enables an input dialog for inc-rename.nvim
    --lsp_doc_border = true, -- add a border to hover docs and signature help
  --},
--})
require("catppuccin").setup({
  cmp = true,
  gitsigns = true,
  nvimtree = true,
  treesitter = true,
  rainbow_delimiters = true,
  telescope = {
    enabled = true,
    -- style = "nvchad"
  },
  lsp_trouble = true,
  mason = true,
  dropbar = {
      enabled = true,
      color_mode = false, -- enable color for kind's texts, not just kind's icons
  },
  leap = true,
  noice = true
})
local wilder = require('wilder')
wilder.setup({modes = {':'}})
require("toggleterm").setup({
  open_mapping = [[<c-\>]],
  direction = 'float',
})

function _G.set_terminal_keymaps()
  local opts = {buffer = 0}
  vim.keymap.set('t', '<esc>', [[<C-\><C-n>]], opts)
  vim.keymap.set('t', 'jk', [[<C-\><C-n>]], opts)
  vim.keymap.set('t', '<C-h>', [[<Cmd>wincmd h<CR>]], opts)
  vim.keymap.set('t', '<C-j>', [[<Cmd>wincmd j<CR>]], opts)
  vim.keymap.set('t', '<C-k>', [[<Cmd>wincmd k<CR>]], opts)
  vim.keymap.set('t', '<C-l>', [[<Cmd>wincmd l<CR>]], opts)
  vim.keymap.set('t', '<C-w>', [[<C-\><C-n><C-w>]], opts)
end

-- if you only want these mappings for toggle term use term://*toggleterm#* instead
vim.cmd('autocmd! TermOpen term://*toggleterm#* lua set_terminal_keymaps()')

vim.keymap.set('n', '<c-n>', function()
    require('focus').split_nicely()
end, { desc = 'split nicely' })
require("codesnap").setup({
    has_line_number = true,
    has_breadcrumbs = true
})
