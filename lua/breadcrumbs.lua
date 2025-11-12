-- Breadcrumbs toggle module with smart guards
-- Provides on-demand breadcrumb navigation using nvim-navic

local M = {}

-- State tracking
M.enabled = false
M.auto_hide_timer = nil

-- Configuration
M.config = {
  max_file_lines = 5000, -- Disable for very large files
  auto_hide_delay = 3000, -- Auto-hide after 3 seconds (0 to disable)
  excluded_filetypes = {
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
    "CHADTree",
    "terminal",
  },
}

-- Check if breadcrumbs should be available for current buffer
local function is_breadcrumbs_available()
  -- Check if navic is available
  local has_navic, navic = pcall(require, "nvim-navic")
  if not has_navic then
    return false, "nvim-navic not available"
  end

  -- Check if LSP is attached and provides document symbols
  if not navic.is_available() then
    return false, "No LSP with documentSymbol capability attached"
  end

  -- Check file type
  local ft = vim.bo.filetype
  if vim.tbl_contains(M.config.excluded_filetypes, ft) then
    return false, "Excluded filetype: " .. ft
  end

  -- Check file size
  local line_count = vim.api.nvim_buf_line_count(0)
  if line_count > M.config.max_file_lines then
    return false, string.format("File too large: %d lines (max: %d)", line_count, M.config.max_file_lines)
  end

  return true, "Available"
end

-- Show breadcrumbs in winbar
function M.show()
  local available, reason = is_breadcrumbs_available()
  if not available then
    vim.notify("Breadcrumbs not available: " .. reason, vim.log.levels.WARN)
    return false
  end

  local navic = require("nvim-navic")
  local winbar_content = navic.get_location()

  if winbar_content and winbar_content ~= "" then
    vim.wo.winbar = "%#NavicText#" .. winbar_content
    M.enabled = true

    -- Set up auto-hide timer if configured
    if M.config.auto_hide_delay > 0 then
      if M.auto_hide_timer then
        M.auto_hide_timer:stop()
        M.auto_hide_timer:close()
      end

      M.auto_hide_timer = vim.loop.new_timer()
      M.auto_hide_timer:start(
        M.config.auto_hide_delay,
        0,
        vim.schedule_wrap(function()
          M.hide()
        end)
      )
    end

    return true
  else
    vim.notify("No breadcrumbs available for current location", vim.log.levels.INFO)
    return false
  end
end

-- Hide breadcrumbs
function M.hide()
  vim.wo.winbar = nil
  M.enabled = false

  -- Clean up auto-hide timer
  if M.auto_hide_timer then
    M.auto_hide_timer:stop()
    M.auto_hide_timer:close()
    M.auto_hide_timer = nil
  end
end

-- Toggle breadcrumbs display
function M.toggle()
  if M.enabled then
    M.hide()
    vim.notify("Breadcrumbs hidden", vim.log.levels.INFO)
  else
    if M.show() then
      vim.notify("Breadcrumbs shown", vim.log.levels.INFO)
    end
  end
end

-- Update breadcrumbs content (call when cursor moves if enabled)
function M.update()
  if not M.enabled then
    return
  end

  local available, _ = is_breadcrumbs_available()
  if not available then
    M.hide()
    return
  end

  local navic = require("nvim-navic")
  local winbar_content = navic.get_location()

  if winbar_content and winbar_content ~= "" then
    vim.wo.winbar = "%#NavicText#" .. winbar_content
  else
    vim.wo.winbar = "%#NavicText#No symbols available"
  end
end

-- Get status for statusline integration (optional)
function M.get_status()
  if not M.enabled then
    return ""
  end

  local has_navic, navic = pcall(require, "nvim-navic")
  if not has_navic or not navic.is_available() then
    return ""
  end

  local location = navic.get_location()
  if location and location ~= "" then
    -- Truncate for statusline display
    if #location > 50 then
      location = location:sub(1, 47) .. "..."
    end
    return location
  end

  return ""
end

-- Setup function (called from plugin configuration)
function M.setup(opts)
  -- Merge user config
  if opts then
    M.config = vim.tbl_deep_extend("force", M.config, opts)
  end

  -- Create autocmds for updating breadcrumbs when enabled
  vim.api.nvim_create_autocmd({ "CursorMoved", "CursorMovedI" }, {
    group = vim.api.nvim_create_augroup("BreadcrumbsUpdate", { clear = true }),
    callback = function()
      -- Only update if breadcrumbs are enabled
      if M.enabled then
        -- Debounce updates to avoid performance issues
        vim.defer_fn(function()
          M.update()
        end, 100)
      end
    end,
  })

  -- Hide breadcrumbs when entering excluded filetypes
  vim.api.nvim_create_autocmd("FileType", {
    group = vim.api.nvim_create_augroup("BreadcrumbsFileType", { clear = true }),
    pattern = M.config.excluded_filetypes,
    callback = function()
      if M.enabled then
        M.hide()
      end
    end,
  })

  -- Clean up when buffer is deleted
  vim.api.nvim_create_autocmd("BufDelete", {
    group = vim.api.nvim_create_augroup("BreadcrumbsCleanup", { clear = true }),
    callback = function()
      if M.auto_hide_timer then
        M.auto_hide_timer:stop()
        M.auto_hide_timer:close()
        M.auto_hide_timer = nil
      end
    end,
  })
end

return M
