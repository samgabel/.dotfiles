-- TODO: set up after/ to language specific settings (like indent format):
-- https://www.reddit.com/r/neovim/comments/x3zp6t/usage_of_afterftplugin_directory_for/

-- INIT
require "init.launch"
require "init.options"
require "init.keymaps"
require "init.autocmds"
require "init.functions"

-- PLUGIN
spec "plugin.alpha"
spec "plugin.breadcrumbs"
spec "plugin.cmp"
spec "plugin.colorscheme"
spec "plugin.dap"
spec "plugin.gitsigns"
spec "plugin.lspconfig"
spec "plugin.lualine"
spec "plugin.mason"
spec "plugin.neo-tree"
spec "plugin.noice"
spec "plugin.none-ls"
spec "plugin.telescope"
spec "plugin.toggleterm"
spec "plugin.treesitter"
spec "plugin.whichkey"

-- SUPPORT
spec "plugin.support.autopairs"
spec "plugin.support.dap-ui"
spec "plugin.support.illuminate"
-- spec "plugin.support.indentline"
spec "plugin.support.navic"
spec "plugin.support.rainbow-delimiters"
spec "plugin.support.schemastore"
spec "plugin.support.twilight"

-- EXTRAS
spec "plugin.extra.cellular-automaton"
spec "plugin.extra.comment"
spec "plugin.extra.harpoon"
spec "plugin.extra.hop"
spec "plugin.extra.markdown-preview"
spec "plugin.extra.neogit"
spec "plugin.extra.neotest"
spec "plugin.extra.nomodoro"
spec "plugin.extra.quick-code-runner"
spec "plugin.extra.obsidian"
spec "plugin.extra.silicon"
spec "plugin.extra.surround"
spec "plugin.extra.symbol-usage"
spec "plugin.extra.todo-comments"
spec "plugin.extra.trouble"
spec "plugin.extra.zen-mode"

-- Daps
spec "plugin.dapsettings.dap-python"

-- LAZY
require "init.lazy"
