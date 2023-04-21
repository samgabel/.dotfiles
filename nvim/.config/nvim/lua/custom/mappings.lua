local M = {}

-- Your custom mappings
M.live_substitution = {
  n = {
    ["<leader>rs"] = { '*:%s//<C-r><C-w>', "Live substitution"}
  }
}

return M
