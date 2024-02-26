local M = {
    -- DIRECOTRY TREE
    "nvim-neo-tree/neo-tree.nvim",
    branch = "v3.x",
    event = "VeryLazy",
    dependencies = {
        "nvim-lua/plenary.nvim",
        "nvim-tree/nvim-web-devicons",
        "MunifTanjim/nui.nvim",
        -- "3rd/image.nvim", -- Optional image support in preview window: See `# Preview Mode` for more information
    },
}

function M.config()
    local wk = require "which-key"
    wk.register {
        ["<leader>e"] = { "<CMD>Neotree focus left<CR>", "Filesystem" }, -- toggle neotree directories
    }

    require("neo-tree").setup {

        window = {
            mappings = {
                ["o"] = { "toggle_preview", config = { use_float = true, use_image_nvim = true } },
                ["O"] = "focus_preview",
                ["s"] = "none",
                ["S"] = "none",
                ["<c-x>"] = "open_split",
                ["<c-v>"] = "open_vsplit",
            },
        },
        filesystem = {
            window = {
                position = "current", -- sets neo-tree as netrw window  --since neo-tree is lazy-loaded right now it won't work
                mappings = {
                    ["h"] = "navigate_up",
                    ["l"] = "set_root",

                    -- remove default keymaps
                    ["."] = "none",
                    ["<"] = "none",
                    [">"] = "none",
                    ["<bs>"] = "none",
                    ["<space>"] = "none",
                    ["A"] = "none",
                    ["C"] = "none",
                    ["P"] = "none",
                    ["f"] = "none",
                    ["e"] = "none",
                    ["t"] = "none",
                    ["w"] = "none",
                    ["[g"] = "none",
                    ["]g"] = "none",
                    ["oc"] = "none",
                    ["od"] = "none",
                    ["og"] = "none",
                    ["om"] = "none",
                    ["on"] = "none",
                    ["os"] = "none",
                    ["ot"] = "none",
                },
                fuzzy_finder_mappings = { -- sets selection navigation for search
                    ["<C-j>"] = "move_cursor_down",
                    ["<C-k>"] = "move_cursor_up",
                },
            },
        },
    }
end

--  event = 'after_render',
--  handler = function ()
--    local state = require('neo-tree.sources.manager').get_state('filesystem')
--    if not require('neo-tree.sources.common.preview').is_active() then
--      state.config = { use_float = false } -- or whatever your config is
--      state.commands.toggle_preview(state)
--    end
--  end

return M
