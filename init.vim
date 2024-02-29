scriptencoding utf-8
"pre-plugins settings
lua << END
vim.g.loaded = 1
vim.g.loaded_netrwPlugin = 1
END

lua require('plugins')
colorscheme tokyonight-day
if has('win32') || has('win64')
      source $HOME\AppData\Local\nvim\settings.vim
else
      source $HOME/.config/nvim/settings.vim
endif
syntax enable


"FOLDING {
  set foldmethod=syntax
  set foldnestmax=3
  set foldlevel=2
  set foldenable
  nnoremap <space> za
"}

" COLORS {
  let $NVIM_TUI_ENABLE_TRUE_COLOR=1
  if has('termguicolors')
    set termguicolors
  endif
  set background=light
"}

lua << EOF
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
  vim.keymap.set("n", "<leader>xx", function() require("trouble").toggle() end)
  vim.keymap.set("n", "<leader>xw", function() require("trouble").toggle("workspace_diagnostics") end)
  vim.keymap.set("n", "<leader>xd", function() require("trouble").toggle("document_diagnostics") end)
  vim.keymap.set("n", "<leader>xq", function() require("trouble").toggle("quickfix") end)
  vim.keymap.set("n", "<leader>xl", function() require("trouble").toggle("loclist") end)
  vim.keymap.set("n", "gR", function() require("trouble").toggle("lsp_references") end)
  local actions = require("telescope.actions")
  local trouble = require("trouble.providers.telescope")
  require('telescope').setup {
      extensions = {
          fzy_native = {
              override_generic_sorter = false,
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
      --{ name = 'nvim_lsp'},
      { name = 'luasnip'},
      { name = 'git'},
      { name = 'copilot'},
      { name = 'buffer'},
      { name = 'path'},
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
  require("mason-lspconfig").setup()
  require("mason-lspconfig").setup_handlers {
      function (server_name)
        lspconfig[server_name].setup(lsp_opts)
      end,
  }
  require'lspconfig'.solargraph.setup({})
  require'lspconfig'.luals.setup({})
  require'lspconfig'.gopls.setup({})
  require'lspconfig'.bufls.setup({})
  require'lspconfig'.yamlls.setup({})
  require'lspconfig'.vimls.setup({})
  require'lspconfig'.standardrb.setup({})
  require'lspconfig'.eslint.setup({})
   

  require('lualine').setup {
      options = {
          theme = 'auto',
          component_separators = '',
          section_separators = '',
      },
      extensions = {'trouble', 'lazy', 'fzf', 'quickfix'},
  }
  require('lualine').get_config()
  local null_ls = require("null-ls")

  null_ls.setup({
      sources = {
          null_ls.builtins.formatting.stylua,
          null_ls.builtins.code_actions.gitrebase,
          null_ls.builtins.diagnostics.reek,
          null_ls.builtins.diagnostics.rubocop,
          null_ls.gitsigns,
          null_ls.builtins.diagnostics.golangci_lint,
          null_ls.builtins.diagnostics.vint,
          null_ls.builtins.diagnostics.buf,
          null_ls.builtins.diagnostics.spectral,
          null_ls.builtins.formatting.rubyfmt,
          null_ls.builtins.formatting.rufo,
      },
  })
EOF

"NERD
let g:NERDCompactSexyComs = 1

"remap telescope
nnoremap <C-P> <cmd>Telescope find_files<cr>

let g:lion_squeeze_spaces = 1
