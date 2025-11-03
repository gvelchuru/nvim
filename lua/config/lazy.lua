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
    -- Core icon provider (mocks nvim-web-devicons for compatibility)
    {
      "echasnovski/mini.icons",
      lazy = false,
      priority = 1000,
      config = function()
        require("mini.icons").setup()
        MiniIcons.mock_nvim_web_devicons()
      end,
    },
    -- import your plugins
    { import = "plugins" },
    --AESTHETIC
    {
      "nvim-lualine/lualine.nvim",
      event = "VeryLazy",
      config = function()
        require("lualine").setup({
          options = {
            theme = "auto",
            component_separators = "",
            section_separators = "",
          },
          extensions = { "trouble", "lazy", "fzf", "quickfix" },
        })
      end,
    },
    {
      "catppuccin/nvim",
      name = "catppuccin",
      priority = 1000,
      lazy = false,
      config = function()
        require("catppuccin").setup({
          cmp = true,
          gitsigns = true,
          nvimtree = true,
          treesitter = true,
          rainbow_delimiters = true,
          telescope = {
            enabled = true,
          },
          lsp_trouble = true,
          mason = true,
          dropbar = {
            enabled = true,
            color_mode = false,
          },
          leap = true,
          noice = true,
        })
      end,
    },
    { "tpope/vim-sleuth", event = { "BufReadPost", "BufNewFile" } }, --heuristically set indent
    {
      "nvim-treesitter/nvim-treesitter",
      event = { "BufReadPost", "BufNewFile" },
      build = ":TSUpdate",
      config = function()
        require("treesitter")
      end,
    },
    {
      "ms-jpq/chadtree",
      branch = "chad",
      keys = {
        { "<leader>e", "<cmd>CHADopen<cr>", desc = "CHADTree file explorer" },
      },
      build = ":CHADdeps",
    },
    { "bekaboo/dropbar.nvim", event = "VeryLazy" }, -- Lazy-load for performance
    { "HiPhish/rainbow-delimiters.nvim", event = "BufReadPost" },
    { "RRethy/vim-illuminate", event = "BufReadPost" },
    {
      "goolord/alpha-nvim",
      config = function()
        require("alpha").setup(require("alpha.themes.startify").config)
      end,
    },
    {
      "mistricky/codesnap.nvim",
      build = "make",
      cmd = { "CodeSnap", "CodeSnapSave" },
      config = function()
        require("codesnap").setup({
          has_line_number = true,
          has_breadcrumbs = true,
        })
      end,
    },

    --TEXT OBJECTS
    { "tpope/vim-repeat", keys = "." },
    { "tpope/vim-unimpaired" },
    { "nelstrom/vim-visual-star-search", lazy = true, keys = { "*", "#" } },
    {
      "tris203/precognition.nvim",
      event = "VeryLazy",
      opts = {
        startVisible = true, -- Enable movement hints
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
    {
      "ggandor/leap.nvim",
      keys = {
        { "s", mode = { "n", "x", "o" }, desc = "Leap forward" },
        { "S", mode = { "n", "x", "o" }, desc = "Leap backward" },
      },
    },
    {
      "nvim-telescope/telescope.nvim",
      dependencies = {
        "nvim-lua/plenary.nvim",
        { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
      },
      keys = {
        { "<Leader>g", "<cmd>Telescope live_grep<cr>", desc = "Live grep" },
      },
      config = function()
        local actions = require("telescope.actions")
        local trouble = require("trouble.sources.telescope")
        require("telescope").setup({
          extensions = {
            fzf = {
              fuzzy = true,
              override_generic_sorter = true,
              override_file_sorter = true,
              case_mode = "smart_case",
            },
          },
          pickers = {
            find_files = {
              find_command = { "rg", "--files", "--hidden", "--glob", "!**/.git/*", "--glob", "!node_modules/*" },
            },
          },
          defaults = {
            mappings = {
              i = { ["<c-t>"] = trouble.open },
              n = { ["<c-t>"] = trouble.open },
            },
          },
        })
        require("telescope").load_extension("fzf")
      end,
    },
    {
      "danielfalk/smart-open.nvim",
      branch = "0.2.x",
      dependencies = {
        "nvim-telescope/telescope.nvim",
        "kkharji/sqlite.lua",
        -- Only required if using match_algorithm fzf
        { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
      },
      keys = {
        {
          "<C-P>",
          function()
            require("telescope").extensions.smart_open.smart_open()
          end,
          desc = "Smart open files (frecency)",
        },
      },
      config = function()
        require("telescope").load_extension("smart_open")
      end,
    },

    --GIT
    {
      "NeogitOrg/neogit",
      cmd = "Neogit",
      keys = {
        { "<leader>gs", "<cmd>Neogit<cr>", desc = "Neogit status" },
        { "<leader>gc", "<cmd>Neogit commit<cr>", desc = "Neogit commit" },
        { "<leader>gp", "<cmd>Neogit push<cr>", desc = "Neogit push" },
        { "<leader>gl", "<cmd>Neogit log<cr>", desc = "Neogit log" },
      },
      dependencies = {
        "nvim-lua/plenary.nvim",
        "sindrets/diffview.nvim",
        "nvim-telescope/telescope.nvim",
      },
      config = function()
        require("neogit").setup({
          integrations = {
            telescope = true,
            diffview = true,
          },
          commit_editor = {
            kind = "split",
          },
          signs = {
            section = { "", "" },
            item = { "", "" },
            hunk = { "", "" },
          },
        })
      end,
    },
    {
      "sindrets/diffview.nvim",
      cmd = { "DiffviewOpen", "DiffviewFileHistory" },
      keys = {
        { "<leader>gd", "<cmd>DiffviewOpen<cr>", desc = "Diffview" },
      },
      config = function()
        require("diffview").setup()
      end,
    },
    {
      "lewis6991/gitsigns.nvim",
      event = { "BufReadPost", "BufNewFile" },
      config = function()
        require("gitsigns").setup({
          current_line_blame = false,
          signcolumn = true,
        })
      end,
      dependencies = { "folke/trouble.nvim" },
    },

    --SURROUND
    --{ "tpope/vim-surround" },
    { "wellle/targets.vim" },
    { "michaeljsmith/vim-indent-object" },

    --COMPLETION/LINTING
    {
      "hrsh7th/nvim-cmp",
      event = "InsertEnter",
      dependencies = {
        "neovim/nvim-lspconfig",
        "hrsh7th/cmp-nvim-lsp",
        "hrsh7th/cmp-buffer",
        "hrsh7th/cmp-path",
        "hrsh7th/cmp-cmdline",
        "L3MON4D3/LuaSnip",
        "saadparwaiz1/cmp_luasnip",
        "onsails/lspkind.nvim",
        "zbirenbaum/copilot-cmp",
        -- REMOVED: cmp-nvim-lsp-document-symbol (use Telescope document_symbols)
        -- REMOVED: cmp-nvim-lsp-signature-help (noice.nvim handles this)
        -- REMOVED: cmp-rg (too slow, use Telescope live_grep)
        -- REMOVED: cmp-git (limited use case)
        -- REMOVED: fuzzy.nvim (not needed with fzf)
      },
      config = function()
        local cmp = require("cmp")
        local lspkind = require("lspkind")
        cmp.setup({
          snippet = {
            expand = function(args)
              require("luasnip").lsp_expand(args.body)
            end,
          },
          window = {},
          mapping = cmp.mapping.preset.insert({
            ["<C-b>"] = cmp.mapping.scroll_docs(-4),
            ["<C-f>"] = cmp.mapping.scroll_docs(4),
            ["<C-Space>"] = cmp.mapping.complete(),
            ["<C-e>"] = cmp.mapping.abort(),
            ["<CR>"] = cmp.mapping.confirm({ select = true }),
          }),
          sources = cmp.config.sources({
            { name = "nvim_lsp" }, -- FIX: Add actual LSP completion!
            { name = "copilot", priority = 100 },
            { name = "luasnip", priority = 90 },
            { name = "buffer", keyword_length = 3 },
            { name = "path" },
            -- REMOVED: nvim_lsp_document_symbol (redundant)
            -- REMOVED: nvim_lsp_signature_help (noice handles it)
            -- REMOVED: fuzzy_buffer (use standard buffer)
            -- REMOVED: fuzzy_path (use standard path)
            -- REMOVED: rg (too slow)
            -- REMOVED: git (limited value)
          }),
          formatting = {
            format = lspkind.cmp_format({
              mode = "symbol",
              maxwidth = 50,
              ellipsis_char = "...",
              show_labelDetails = true,
            }),
          },
        })
        cmp.setup.cmdline({ "/", "?" }, {
          mapping = cmp.mapping.preset.cmdline(),
          sources = {
            { name = "buffer" },
          },
        })
        cmp.setup.cmdline(":", {
          mapping = cmp.mapping.preset.cmdline(),
          sources = cmp.config.sources({
            { name = "path" },
          }, {
            { name = "cmdline" },
          }),
        })
      end,
    },
    {
      "folke/trouble.nvim",
      cmd = "Trouble", -- Load only when :Trouble command is used
      keys = {
        {
          "gR",
          function()
            require("trouble").toggle("lsp_references")
          end,
          desc = "Toggle LSP references",
        },
      },
      config = function()
        require("trouble").setup()
      end,
    },
    {
      "rshkarin/mason-nvim-lint",
      event = { "BufReadPost", "BufNewFile" },
      config = function()
        require("mason-nvim-lint").setup()
      end,
    },
    {
      "mason-org/mason.nvim",
      event = "VeryLazy", -- Lazy-load for performance, not needed at startup
      cmd = { "Mason", "MasonInstall", "MasonUpdate" },
      dependencies = {
        "mason-org/mason-lspconfig.nvim",
        "neovim/nvim-lspconfig",
      },
      config = function()
        require("mason").setup()
        require("mason-lspconfig").setup({
          ensure_installed = {
            "lua_ls",
            "ts_ls",
            "eslint",
            "jsonls",
            "html",
            "cssls",
            "gopls",
            "basedpyright",
            -- Using rubocop only for Ruby (removed ruby_lsp, solargraph, standardrb to avoid conflicts)
          },
          automatic_enable = true,
        })

        -- LSP on_attach moved from init.lua for lazy loading
        -- Will be triggered when LSP servers attach
        vim.api.nvim_create_autocmd("LspAttach", {
          callback = function(args)
            local bufnr = args.buf
            local bufopts = { buffer = bufnr }
            vim.keymap.set("n", "gd", vim.lsp.buf.definition, bufopts)
            vim.keymap.set("n", "<LEADER>k", vim.lsp.buf.hover, bufopts)
            vim.keymap.set("n", "<LEADER>r", vim.lsp.buf.rename, bufopts)
            vim.keymap.set("n", "<LEADER>a", vim.lsp.buf.code_action, bufopts)
            vim.keymap.set("v", "<LEADER>a", vim.lsp.buf.code_action, bufopts)
          end,
        })
      end,
    },
    {
      "mfussenegger/nvim-lint",
      event = { "BufReadPost", "BufNewFile", "BufWritePost" },
      config = function()
        require("lint").linters_by_ft = {
          markdown = { "vale" },
          ruby = { "rubocop", "trivy" },
        }
        vim.api.nvim_create_autocmd({ "BufWritePost" }, {
          callback = function()
            require("lint").try_lint()
          end,
        })
      end,
    },

    --SPLITTING
    {
      "nvim-focus/focus.nvim",
      version = false,
      event = "VeryLazy", -- Load after startup but needs to be active for window navigation auto-resize
      keys = {
        {
          "<c-n>",
          function()
            require("focus").split_nicely()
          end,
          desc = "Split nicely",
        },
      },
      config = function()
        require("focus").setup()
      end,
    },

    --GENERAL
    --{
    --	"pocco81/auto-save.nvim",
    --},
    {
      "zbirenbaum/copilot-cmp",
      event = "InsertEnter", -- Match copilot.lua event to prevent eager loading
      dependencies = { "zbirenbaum/copilot.lua" },
      config = function()
        require("copilot_cmp").setup()
      end,
    },
    {
      "zbirenbaum/copilot.lua",
      event = "InsertEnter",
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
      event = "BufReadPost",
      config = function()
        vim.o.undofile = true
        require("fundo").setup()
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
    {
      "akinsho/toggleterm.nvim",
      version = "*",
      keys = { "<c-\\>" },
      config = function()
        require("toggleterm").setup({
          open_mapping = [[<c-\>]],
          direction = "float",
        })

        function _G.set_terminal_keymaps()
          local opts = { buffer = 0 }
          vim.keymap.set("t", "<esc>", [[<C-\><C-n>]], opts)
          vim.keymap.set("t", "jk", [[<C-\><C-n>]], opts)
          vim.keymap.set("t", "<C-h>", [[<Cmd>wincmd h<CR>]], opts)
          vim.keymap.set("t", "<C-j>", [[<Cmd>wincmd j<CR>]], opts)
          vim.keymap.set("t", "<C-k>", [[<Cmd>wincmd k<CR>]], opts)
          vim.keymap.set("t", "<C-l>", [[<Cmd>wincmd l<CR>]], opts)
          vim.keymap.set("t", "<C-w>", [[<C-\><C-n><C-w>]], opts)
        end

        vim.cmd("autocmd! TermOpen term://*toggleterm#* lua set_terminal_keymaps()")
      end,
    },

    --CSV
    { "chrisbra/csv.vim", ft = "csv" }, -- Only load for CSV files

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
      event = "VeryLazy", -- Lazy-load for performance, fancy UI not needed at startup
      opts = {
        cmdline = {
          enabled = true,
          view = "cmdline_popup", -- Replaces wilder.nvim functionality
        },
      },
      dependencies = {
        "MunifTanjim/nui.nvim",
        "rcarriga/nvim-notify",
      },
    },
    { "dstein64/vim-startuptime" },
    {
      "f-person/auto-dark-mode.nvim",
      opts = {
        set_dark_mode = function()
          vim.api.nvim_set_option_value("background", "dark", {})
          vim.cmd([[colorscheme catppuccin-macchiato]])
        end,
        set_light_mode = function()
          vim.api.nvim_set_option_value("background", "light", {})
          vim.cmd([[colorscheme catppuccin-latte]])
        end,
        update_interval = 3000,
        fallback = "light",
      },
    },
    --LLM
    {
      "greggh/claude-code.nvim",
      dependencies = {
        "nvim-lua/plenary.nvim", -- Required for git operations
      },
      config = function()
        require("claude-code").setup()
      end,
    },
  },
  install = { colorscheme = { "catppuccin-frappe" } },
  -- automatically check for plugin updates
  checker = { enabled = true },
  performance = {
    cache = {
      enabled = true,
    },
    reset_packpath = true, -- reset the package path to improve startup time
    rtp = {
      reset = true, -- reset the runtime path to $VIMRUNTIME and your config directory
      ---@type string[]
      paths = {}, -- add any custom paths here that you want to includes in the rtp
      disabled_plugins = {
        "gzip",
        -- "matchit",
        -- "matchparen",
        "netrwPlugin",
        "tarPlugin",
        "tohtml",
        "tutor",
        "zipPlugin",
      },
    },
  },
})
