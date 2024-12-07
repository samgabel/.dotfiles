local M = {
    "folke/snacks.nvim",
    lazy = false
}

function M.config()

    require("which-key").register({
        prefix = "<leader>",
        g = {
            g = { function() require("snacks").lazygit.open() end, "Open" },
        },
    })

    require("snacks").setup({
        lazygit = {
            configure = true,
        }
    })

end

return M
