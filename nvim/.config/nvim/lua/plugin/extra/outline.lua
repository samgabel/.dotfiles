local M = {
    "hedyhli/outline.nvim",
    -- cmd = { "Outline", "OutlineOpen" },
    event = "VeryLazy"
}


function M.config()

    require("which-key").register({
        ["<leader>so"] = { "<CMD>Outline<CR>", "Outline" }
    })

    require("outline").setup({
        outline_window = {
            position = "left"
        }
    })

end


return M
