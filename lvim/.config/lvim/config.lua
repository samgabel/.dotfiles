-- Read the docs: https://www.lunarvim.org/docs/configuration
-- Video Tutorials: https://www.youtube.com/watch?v=sFA9kX-Ud_c&list=PLhoH5vyxr6QqGu0i7tt_XoVK9v-KvZ3m6
-- Forum: https://www.reddit.com/r/lunarvim/
-- Discord: https://discord.com/invite/Xb9B4Ny


-- fix issue with using <c-l> in terminal
vim.keymap.del("t", "<c-l>")


-- general
lvim.log.level = "warn"
lvim.format_on_save = true
lvim.colorscheme = "catppuccin"
lvim.builtin.cmp.confirm_opts.select = true
lvim.leader = "space"

lvim.builtin.nvimtree.setup.view.side = "left"
lvim.builtin.nvimtree.setup.view.width = 50
lvim.builtin.treesitter.highlight.enabled = true


-- switch buffers
lvim.keys.normal_mode["<Tab>"] = ":bnext<CR>"
lvim.keys.normal_mode["<S-Tab>"] = ":bprevious<CR>"


-- Additional Plugins
lvim.plugins = {
  { "justinmk/vim-sneak" },
  { "tpope/vim-surround" },
  -- themes
  { "getomni/neovim" },
  { "Mofiqul/dracula.nvim" },
  { "catppuccin/nvim" }
}

