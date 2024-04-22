local M = {
    "nvim-lualine/lualine.nvim",
    -- lazy = false,
    event = "BufRead",
    dependencies = {
        {
            "AndreM222/copilot-lualine",
            event = "VeryLazy"
        },
    },
}


-- Initial update of tmux session info
UpdateTmuxSessionInfo()
-- UpdateTmuxSessionInfo() when <C-s> is pressed (in terminal <C-s> will freeze until <C-q)
-- in tmux.conf the "z" keybind will also send <C-s> to vim in additon to toggling zoom
vim.api.nvim_set_keymap('', '<C-s>', ':lua UpdateTmuxSessionInfo()<CR>', { noremap = true, silent = true })


function M.config()
    ---@diagnostic disable: undefined-field, need-check-nil
    require("lualine").setup {
        options = {
            component_separators = { left = "", right = "" },
            section_separators = { left = "", right = "" },
            globalstatus = true,
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
