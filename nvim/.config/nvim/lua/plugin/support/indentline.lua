local M = {
    "lukas-reineke/indent-blankline.nvim",
    ft = { "yaml", "yml", "toml" }
}

function M.config()
    require("ibl").setup ({
        indent = {
            char = "▎",
        },
        scope = {
            enabled = false
        }
    })
end

return M
