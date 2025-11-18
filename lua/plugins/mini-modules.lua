return {
  -- Mini.nvim comment module - replaces Comment.nvim
  {
    "echasnovski/mini.comment",
    keys = {
      { "gc", mode = { "n", "v" }, desc = "Comment toggle" },
      { "gb", mode = { "n", "v" }, desc = "Comment toggle blockwise" },
    },
    config = function()
      require("mini.comment").setup()
    end,
  },

  -- Mini.nvim pairs module - adds autopairs functionality
  {
    "echasnovski/mini.pairs",
    event = "InsertEnter",
    config = function()
      require("mini.pairs").setup()
    end,
  },

  -- Mini.nvim surround module - adds surround operations
  {
    "echasnovski/mini.surround",
    keys = {
      { "sa", mode = { "n", "v" }, desc = "Add surrounding" },
      { "sd", desc = "Delete surrounding" },
      { "sr", desc = "Replace surrounding" },
      { "sf", desc = "Find right surrounding" },
      { "sF", desc = "Find left surrounding" },
      { "sh", desc = "Highlight surrounding" },
      { "sn", desc = "Update n_lines" },
    },
    config = function()
      require("mini.surround").setup()
    end,
  },

  -- Mini.nvim indentscope module - replaces vim-indent-object with enhanced visualization
  {
    "echasnovski/mini.indentscope",
    event = { "BufReadPost", "BufNewFile" },
    config = function()
      require("mini.indentscope").setup({
        symbol = "│",
        options = { try_as_border = true },
        draw = {
          delay = 100,
          animation = require("mini.indentscope").gen_animation.none(), -- Disable animation for performance
        },
      })

      -- Disable for certain filetypes
      vim.api.nvim_create_autocmd("FileType", {
        pattern = {
          "help",
          "alpha",
          "dashboard",
          "neo-tree",
          "Trouble",
          "lazy",
          "mason",
          "notify",
          "toggleterm",
          "lazyterm",
        },
        callback = function()
          vim.b.miniindentscope_disable = true
        end,
      })
    end,
  },

  -- Mini.nvim bracketed module - replaces vim-unimpaired with enhanced functionality
  {
    "echasnovski/mini.bracketed",
    keys = {
      { "[", desc = "Previous" },
      { "]", desc = "Next" },
    },
    config = function()
      require("mini.bracketed").setup()
    end,
  },

  -- REMOVED: mini.statusline (replaced with vim-airline)
  -- {
  --   "echasnovski/mini.statusline",
  --   event = "VeryLazy",
  --   config = function()
  --     local statusline = require("mini.statusline")
  --     statusline.setup({
  --       use_icons = true,
  --       set_vim_settings = true,
  --     })
  --   end,
  -- },

  -- REMOVED: mini.starter (user prefers alpha-nvim)
}
