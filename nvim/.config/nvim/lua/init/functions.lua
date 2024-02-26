--------------------------------------- PATH --------------------------------------

-- Function to paste absolute path inline
-- Keybind: <leader>pa
-- File: init.functions
function PasteFilePathInline()
    local file_path = vim.fn.expand "%:p" -- Get the full path of the current file
    ---@diagnostic disable-next-line: unused-local
    local cursor_pos = vim.fn.col "." -- Get the current cursor position
    -- Insert the full path at the cursor position in the current line
    vim.api.nvim_put({ file_path }, "c", true, true)
end

-- Function to paste relative path inline
-- Keybind: <leader>pr
-- File: init.functions
function PasteRelativePathInline()
    local file_path = vim.fn.expand "%" -- Get the relative path of the current file
    ---@diagnostic disable-next-line: unused-local
    local cursor_pos = vim.fn.col "." -- Get the current cursor position
    -- Insert the relative path at the cursor position in the current line
    vim.api.nvim_put({ file_path }, "c", true, true)
end

--------------------------------------- TMUX --------------------------------------
---@diagnostic disable: need-check-nil

-- Store tmux session name
local tmux_session_name = ""
-- Store tmux session zoom state
-- @default False
local tmux_zoomed = false

-- Get tmux session name and zoom status
-- @return The session name [and (󰍉) if pane is zoomed]
-- File: init.functions
function GetTmuxSession()
    return tmux_session_name .. (tmux_zoomed and " (󰍉)" or "")
end

-- Function to update tmux session name and zoom state
-- File: init.functions
function UpdateTmuxSessionInfo()
    local handle = io.popen "tmux display-message -p '#S'"
    tmux_session_name = handle:read "*l" or ""
    handle:close()
    -- lists whether the pane is zoomed or not
    handle = io.popen "tmux list-panes -F '#F'"
    local zoom_info = handle:read "*a" or ""
    handle:close()
    -- if there is a "Z" in the list then the pane is zoomed
    tmux_zoomed = zoom_info:find "Z" ~= nil
end
