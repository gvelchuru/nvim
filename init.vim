"pre-plugins settings
lua << END
vim.g.loaded = 1
vim.g.loaded_netrwPlugin = 1
END

lua require('plugins')
colorscheme tokyonight-day
let g:ale_disable_lsp = 1
if has('win32') || has('win64')
      source $HOME\AppData\Local\nvim\settings.vim
      source $HOME\AppData\Local\nvim\plugins.vim
else
      source $HOME/.config/nvim/settings.vim
      source $HOME/.config/nvim/plugins.vim
endif
syntax enable


"fzf and grep settings {
  "replace grep with rg
  if executable('rg')
    set grepprg=rg\ --vimgrep
    set grepformat=%f:%l:%c:%m,%f:%l:%m
  endif
  command! -bang -nargs=* Find call fzf#vim#grep('rg --column --line-number --no-heading --fixed-strings --ignore-case --no-ignore --hidden --follow --glob "!.git/*" --color "always" '.shellescape(<q-args>), 1, <bang>0)
"}

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

augroup loading
  autocmd!
  autocmd Syntax c,cpp,cs,vim,xml,html,xhtml,perl normal zM

  " Instead of reverting the cursor to the last position in the buffer, we
  " set it to the first line when editing a git commit message
  au FileType gitcommit au! BufEnter COMMIT_EDITMSG call setpos('.', [0, 1, 1, 0])
  " Powershell
  au BufNewFile,BufRead   *.ps1   set ft=powershell
  au BufNewFile,BufRead   *.psd1  set ft=powershell
  au BufNewFile,BufRead   *.psm1  set ft=powershell
  au BufNewFile,BufRead   *.pssc  set ft=powershell
augroup END

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
    additional_vim_regex_highlighting = false,
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
        coc = { theme = 'ivy' }
    },
    defaults = {
        mappings = {
          i = { ["<c-t>"] = trouble.open_with_trouble },
          n = { ["<c-t>"] = trouble.open_with_trouble },
        },
  },
}
require('telescope').load_extension('fzy_native')
require('telescope').load_extension('coc')
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
EOF
