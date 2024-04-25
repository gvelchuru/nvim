vim.g.loaded = 1
vim.g.loaded_netrwPlugin = 1
require('plugins')
vim.cmd('colorscheme catppuccin-macchiato')
vim.cmd('set number')
vim.cmd('set signcolumn=number')
vim.cmd('set ignorecase')
vim.cmd('set smartcase')
vim.cmd('set showmatch')
vim.cmd('set incsearch')
vim.cmd('set hlsearch')
vim.cmd('syntax enable')
vim.env.NVIM_TUI_ENABLE_TRUE_COLOR=1
vim.opt.termguicolors=true
vim.opt.background="dark"
require'nvim-treesitter.configs'.setup {
  ensure_installed = {"c", "lua", "vim", "vimdoc", "query", "go", "ruby"},

  -- Install parsers synchronously (only applied to `ensure_installed`)
  sync_install = false,

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
local trouble = require("trouble.providers.telescope")
require('telescope').setup {
    extensions = {
        fzy_native = {
            override_generic_sorter = true,
            override_file_sorter = true, },
    },
    defaults = {
        mappings = {
          i = { ["<c-t>"] = trouble.open_with_trouble },
          n = { ["<c-t>"] = trouble.open_with_trouble },
        },
  },
}
require('telescope').load_extension('fzy_native')
--require("barbecue.ui").toggle(true)
require('Comment').setup()
local rainbow_delimiters = require 'rainbow-delimiters'

vim.g.rainbow_delimiters = {
    strategy = {
        [''] = rainbow_delimiters.strategy['global'],
        vim = rainbow_delimiters.strategy['local'],
    },
    query = {
        [''] = 'rainbow-delimiters',
        lua = 'rainbow-blocks',
    },
    highlight = {
        'RainbowDelimiterRed',
        'RainbowDelimiterYellow',
        'RainbowDelimiterBlue',
        'RainbowDelimiterOrange',
        'RainbowDelimiterGreen',
        'RainbowDelimiterViolet',
        'RainbowDelimiterCyan',
    }
}
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
  automatic_installation = true
})
require("mason-lspconfig").setup_handlers {
    function (server_name)
      lspconfig[server_name].setup(lsp_opts)
    end,
}
require'lspconfig'.solargraph.setup({})
require'lspconfig'.lua_ls.setup({})
require'lspconfig'.gopls.setup({})
require'lspconfig'.bufls.setup({})
require'lspconfig'.yamlls.setup({})
require'lspconfig'.vimls.setup({})
require'lspconfig'.standardrb.setup({})
require'lspconfig'.eslint.setup({})
require'lspconfig'.biome.setup({})
require'lspconfig'.ember.setup({})
require'lspconfig'.emmet_language_server.setup({})
require'lspconfig'.flow.setup({})
require'lspconfig'.glint.setup({})
require'lspconfig'.quick_lint_js.setup({})
require'lspconfig'.stylelint_lsp.setup({})
require'lspconfig'.tsserver.setup({})
require'lspconfig'.pyright.setup({})
require'lspconfig'.ruff.setup({})
require'lspconfig'.ruff_lsp.setup({})
require'lspconfig'.anakin_language_server.setup({})
require'lspconfig'.biome.setup{}

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
vim.cmd('sign define DiagnosticSignWarn text= texthl=DiagnosticSignWarn linehl= numhl=')
vim.cmd('sign define DiagnosticSignInfo text= texthl=DiagnosticSignInfo linehl= numhl=')
vim.cmd('sign define DiagnosticSignHint text= texthl=DiagnosticSignHint linehl= numhl=')
