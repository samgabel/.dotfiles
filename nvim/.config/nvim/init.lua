-- TODO: set up after/ to language specific settings (like indent format):
-- https://www.reddit.com/r/neovim/comments/x3zp6t/usage_of_afterftplugin_directory_for/

-- INIT --
require "init.launch"
require "init.options"
require "init.keymaps"
require "init.autocmds"
require "init.functions"

-- PLUGIN --
spec "plugin.core.alpha"
spec "plugin.core.breadcrumbs"
spec "plugin.core.cmp"
spec "plugin.core.colorscheme"
spec "plugin.core.dap"
spec "plugin.core.gitsigns"
spec "plugin.core.lspconfig"
spec "plugin.core.lualine"
spec "plugin.core.mason"
spec "plugin.core.neo-tree"
spec "plugin.core.noice"
spec "plugin.core.none-ls"
spec "plugin.core.telescope"
spec "plugin.core.toggleterm"
spec "plugin.core.treesitter"
spec "plugin.core.whichkey"

-- SUPPORT --
spec "plugin.support.autopairs"
spec "plugin.support.dap-ui"
spec "plugin.support.illuminate"
spec "plugin.support.lsp-progress"
spec "plugin.support.navic"
spec "plugin.support.rainbow-delimiters"
spec "plugin.support.schemastore"
spec "plugin.support.twilight"
-- daps
spec "plugin.support.dapsettings.dap-python"

-- EXTRAS --
spec "plugin.extra.cellular-automaton"
spec "plugin.extra.comment"
spec "plugin.extra.harpoon"
spec "plugin.extra.markdown-preview"
spec "plugin.extra.lazygit"
spec "plugin.extra.neotest"
spec "plugin.extra.quick-code-runner"
spec "plugin.extra.silicon"
spec "plugin.extra.surround"
spec "plugin.extra.symbol-usage"
spec "plugin.extra.todo-comments"
spec "plugin.extra.trouble"
spec "plugin.extra.zen-mode"

-- MacOS --
spec "plugin.extra.obsidian"
spec "plugin.extra.leetcode"

-- LAZY
require "init.lazy"
