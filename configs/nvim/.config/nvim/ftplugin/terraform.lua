vim.opt_local.expandtab = true -- convert tabs to spaces
vim.opt_local.shiftwidth = 2 -- the number of spaces inserted for each indentation
vim.opt_local.tabstop = 2 -- insert 2 spaces for a tab

-- indent-line support
local hooks = require("ibl.hooks")
hooks.register(hooks.type.ACTIVE, function()
    return vim.opt_local.filetype:get() == "terraform"
end)
