local M = {
    "folke/which-key.nvim",
    event = "VeryLazy",
}

function M.config()

    -- modifies the time between a key press and the whichkey popup
    vim.o.timeout = true
    vim.o.timeoutlen = 300

    local mappings = {
        a = { "<cmd>Alpha<cr>", "Dashboard" },
        b = { "<cmd>NoiceDismiss<CR>", "Dismiss" },
        q = { "<cmd>confirm q<CR>", "Quit" },
        w = { ":lua vim.wo.wrap = not vim.wo.wrap<CR>", "Wrap" },
        x = { "<cmd>!chmod +x %<CR>", "Chmod +x" },
        -- v = { "<cmd>vsplit | Alpha<CR>", "Split" },
        -- b = { name = "Buffers" }, --get rid of imbedded
        -- expandable --
        f = { name = "Find" },
        g = { name = "Git" },
        h = { name = "Hop", mode = { "n", "v" } },
        l = { name = "Lsp", mode = { "n", "v" } },
        n = { name = "Nomodoro" },
        o = {
            name = "Obsidian",
            l = { name = "Links" },
        },
        p = {
            name = "Path",
            a = { ":lua PasteFilePathInline()<CR>", "Absolute" },
            r = { ":lua PasteRelativePathInline()<CR>", "Relative" },
        },
        t = { name = "Test" },
        y = { name = "Fun" },
        z = { name = "Zen" },
        d = { name = "Debug" },
        r = { name = "Repl", mode = { "n", "v" } },

        -- p = { name = "Plugins" },
    }

    local which_key = require "which-key"
    which_key.setup {
        plugins = {
            marks = true,
            registers = true,
            spelling = {
                enabled = true,
                suggestions = 20,
            },
            presets = {
                operators = false,
                motions = false,
                text_objects = false,
                windows = false,
                nav = false,
                z = false,
                g = false,
            },
        },
        window = {
            border = "rounded",
            position = "bottom",
            padding = { 2, 2, 2, 2 },
        },
        ignore_missing = true,
        show_help = false,
        show_keys = false,
        disable = {
            buftypes = {},
            filetypes = { "TelescopePrompt" },
        },
    }

    local opts = {
        mode = "n", -- NORMAL mode
        prefix = "<leader>",
    }

    which_key.register(mappings, opts)
end

return M
