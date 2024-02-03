local M = {
  "folke/which-key.nvim",
  event = "VeryLazy",
}

function M.config()
  local mappings = {
    a = { "<cmd>Alpha<cr>", "Dashboard" },
    q = { "<cmd>confirm q<CR>", "Quit" },
    d = { "<cmd>NoiceDismiss<CR>" , "DISMISS" },
    v = { "<cmd>vsplit | Alpha<CR>", "Split" },
    b = { name = "Buffers" }, --get rid of imbedded
    f = { name = "Find" },
    g = { name = "Git" },
    h = { name = "Hop", mode = {"n", "v"} },
    l = { name = "Lsp" },
    o = {
      name = "Obsidian",
      l = { name = "Links" },
    },
    t = { name = "Timer" },
    y = { name = "Fun" },
    z = { name = "Zen"}
    -- p = { name = "Plugins" },
    -- d = { name = "Debug" },
    -- t = { name = "Test" },
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
