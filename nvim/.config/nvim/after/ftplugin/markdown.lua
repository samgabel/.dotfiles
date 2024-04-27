-- wrapping enabled
vim.opt_local.wrap = true
-- spelling enabled
vim.opt_local.spell = true
-- https://vimways.org/2018/formatting-lists-with-vim/
-- matches indentation to each wrapped line (uses the length of a match with 'formatlistpat')
vim.opt_local.breakindentopt = "list:-1"
-- markdown list symbols declaration
vim.opt_local.formatlistpat = "^\\s*[-*+>]\\s\\+\\|^\\s*\\d\\+[\\).]\\s*" -- works with `breakindentopt` (in lua/init/options)

