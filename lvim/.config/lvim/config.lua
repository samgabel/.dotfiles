-- fix issue with using <c-l> in terminal
vim.keymap.del("t", "<c-l>")

-- switch buffers
lvim.keys.normal_mode["<Tab>"] = ":bnext<CR>"
lvim.keys.normal_mode["<S-Tab>"] = ":bprevious<CR>"

-- colorscheme
lvim.colorscheme = "catppuccin"

-- Additional Plugins
lvim.plugins = {
  {
  "jackMort/ChatGPT.nvim",
    event = "VeryLazy",
    config = function()
      require("chatgpt").setup()
      require("chatgpt").setup({
        api_key_cmd = "gpg --decrypt ~/secret.txt.gpg 2>/dev/null"
      })
    end,
    dependencies = {
      "MunifTanjim/nui.nvim",
      "nvim-lua/plenary.nvim",
      "nvim-telescope/telescope.nvim"
    }
  },
  { "justinmk/vim-sneak" },
  { "github/copilot.vim" },
  { "tpope/vim-surround" },
  -- themes
  { "getomni/neovim" },
  { "Mofiqul/dracula.nvim" },
  { "catppuccin/nvim" }
}

-- Setup copilot
vim.g.copilot_no_tab_map = true
vim.g.copilot_assume_mapped = true
vim.g.copilot_tab_fallback = ""
local cmp = require "cmp"

lvim.builtin.cmp.mapping["<Tab>"] = function(fallback)
  cmp.mapping.abort()
  local copilot_keys = vim.fn["copilot#Accept"]()
  if copilot_keys ~= "" then
    vim.api.nvim_feedkeys(copilot_keys, "i", true)
  else
    fallback()
  end
end
