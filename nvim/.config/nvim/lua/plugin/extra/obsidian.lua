---@diagnostic disable: missing-fields

local M = {
    "epwalsh/obsidian.nvim",
    version = "*",
    event = "VeryLazy",
    ft = "markdown",
    dependencies = {
        "nvim-lua/plenary.nvim",
    },
    opts = {},
}

function M.config()
    local wk = require "which-key"
    wk.register {
        ["<leader>on"] = { "<cmd>ObsidianNew<cr>", "New File" },
        ["<leader>oo"] = { "<cmd>ObsidianOpen<cr>", "Open" },
        ["<leader>of"] = { "<cmd>ObsidianQuickSwitch<cr>", "Find File" },
        ["<leader>os"] = { "<cmd>ObsidianSearch<cr>", "Search Text" },
        ["<leader>ot"] = { "<cmd>ObsidianTemplate<cr>", "Insert Template" },
        ["<leader>op"] = { "<cmd>ObsidianPasteImg<cr>", "Paste Img" },
        ["<leader>olf"] = { "<cmd>ObsidianFollowLink<cr>", "To Link" },
        ["<leader>olb"] = { "<cmd>ObsidianBacklinks<cr>", "Back Link" },
    }

    -- https://github.com/epwalsh/obsidian.nvim
    require("obsidian").setup {

        workspaces = {
            {
                name = "docs",
                path = "~/Documents/docs",
            },
        },

        -- where notes are first created using <leader>on
        notes_subdir = "ZETTELKASTEN/300-Fleeting",
        new_notes_location = "notes_subdir",

        -- prepends the note path instead of the note id
        wiki_link_func = function(opts)
            if opts.label ~= opts.path then
                return string.format("[[%s|%s]]", opts.path, opts.label)
            else
                return string.format("[[%s]]", opts.path)
            end
        end,
        -- completion = {
        --   prepend_note_id = false,
        --   prepend_note_path = true,
        -- },

        -- disable automatic "Properties" section
        disable_frontmatter = true,

        -- use templates instead
        templates = {
            subdir = "ZETTELKASTEN/assets/templates",
        },

        -- enable external links in buffer
        follow_url_func = function(url)
            vim.fn.jobstart { "open", url }
        end,

        -- brings obsidian app to foreground when running :ObsidianOpen
        open_app_foreground = true,

        -- disables "Create a New Note" from :ObsidianSearch use :ObsidianNewNote instead
        finder_mappings = {},

        -- stores images in this dir using :ObsidianPasteImage
        attachments = {
            img_folder = "ZETTELKASTEN/assets/imgs",
        },
    }
end

return M
