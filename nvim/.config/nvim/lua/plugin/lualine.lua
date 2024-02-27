local M = {
    "nvim-lualine/lualine.nvim",
    event = "VeryLazy",
    -- lazy = false,
    dependencies = {
        {
            "AndreM222/copilot-lualine",
            event = "VeryLazy"
        },
    },
}

-- Initial update of tmux session info
UpdateTmuxSessionInfo()
-- Periodically update tmux session info (every 10 seconds) avoid stuttering when scrolling
vim.loop.new_timer():start(30000, 30000, vim.schedule_wrap(UpdateTmuxSessionInfo))

function M.config()
    ---@diagnostic disable: undefined-field, need-check-nil
    require("lualine").setup {
        options = {
            component_separators = { left = "", right = "" },
            section_separators = { left = "", right = "" },
            ignore_focus = { "NvimTree" },
        },
        sections = {
            lualine_a = {},
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
            lualine_z = { GetTmuxSession },
        },
        extensions = { "quickfix", "man", "fugitive" },
    }
end

return M
