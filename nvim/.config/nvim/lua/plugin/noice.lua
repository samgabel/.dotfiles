local M = {
  "folke/noice.nvim",
  event = "VeryLazy",
  dependencies = {
  -- if you lazy-load any plugin below, make sure to add proper `module="..."` entries
  "MunifTanjim/nui.nvim",
  -- OPTIONAL:
  --   `nvim-notify` is only needed, if you want to use the notification view.
  --   If not available, we use `mini` as the fallback
  -- "rcarriga/nvim-notify",
  },
}

function M.config()

  require("noice").setup({
    cmdline = {
      format = {
        search_down = { icon = "" },
      },
    },
    messages = {
      enabled = true
    },
    popupmenu = {
      enabled = true
    },
    notify = {
      enabled = true
    },
    smart_move = {
      enabled = false
    },
    lsp = {
      progress = {
        enabled = false
      },
    },
    presets = {
      bottom_search = false, -- use a classic bottom cmdline for search
      command_palette = true, -- position the cmdline and popupmenu together
      long_message_to_split = true, -- long messages will be sent to a split
      inc_rename = false, -- enables an input dialog for inc-rename.nvim
      lsp_doc_border = false, -- add a border to hover docs and signature help
    },
  })

    -- needed if notify is used for transparent background
  -- require("notify").setup({
  --   background_colour = "#000000"
  -- })

end

return M
