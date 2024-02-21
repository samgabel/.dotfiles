---@diagnostic disable: undefined-field, need-check-nil

local M = {
  "nvim-lualine/lualine.nvim",
  event = "VeryLazy",
  -- lazy = false,
  dependencies = {
    "AndreM222/copilot-lualine",
  },
}


-- Global variables to store tmux session name and zoom state
local tmux_session_name = ""
local tmux_zoomed = false
-- Function to update tmux session name and zoom state
local function update_tmux_session_info()
    local handle = io.popen("tmux display-message -p '#S'")
    tmux_session_name = handle:read("*l") or ""
    handle:close()
    -- lists whether the pane is zoomed or not
    handle = io.popen("tmux list-panes -F '#F'")
    local zoom_info = handle:read("*a") or ""
    handle:close()
    -- if there is a "Z" in the list then the pane is zoomed
    tmux_zoomed = zoom_info:find("Z") ~= nil
end
-- Initial update of tmux session info
update_tmux_session_info()
-- Get tmux session name and check if the current pane is zoomed
local function get_tmux_session()
    return tmux_session_name .. (tmux_zoomed and " (󰍉)" or "")
end
-- Periodically update tmux session info (every 10 seconds) avoid stuttering when scrolling
vim.loop.new_timer():start(5000, 5000, vim.schedule_wrap(update_tmux_session_info))


function M.config()

  require("lualine").setup {
    options = {
      component_separators = { left = "", right = "" },
      section_separators = { left = "", right = "" },
      ignore_focus = { "NvimTree" },
    },
    sections = {
      lualine_a = { },
      lualine_b = {
        {
          require("noice").api.status.mode.get,
          cond = require("noice").api.status.mode.has,
          color = { fg = "#ff9e64" },
        },
        require("nomodoro").status,
      },
      lualine_c = { "branch", "diff" },
      lualine_x = { "diagnostics", "copilot", "filetype" },
      lualine_y = { "progress" },
      lualine_z = { get_tmux_session },
    },
    extensions = { "quickfix", "man", "fugitive" },
  }
end

return M
