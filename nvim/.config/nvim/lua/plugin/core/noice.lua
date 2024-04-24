local M = {
    "folke/noice.nvim",
    event = "VeryLazy",
    dependencies = {
        -- if you lazy-load any plugin below, make sure to add proper `module="..."` entries
        "MunifTanjim/nui.nvim",
        -- OPTIONAL:
        -- `nvim-notify` is only needed, if you want to use the notification view.
        --   If not available, we use `mini` as the fallback
        "rcarriga/nvim-notify",
    },
}


vim.opt.shortmess:append 's' -- removes the "search hit BOTTOM continuing at TOP" message for search

function M.config()
    require("noice").setup {
        cmdline = {
            view = "cmdline",
            format = {
                cmdline = { icon = " " },
                search_up = { icon = " " },
                search_down = { icon = " " },
                filter = { icon = " " },
                help = { icon = " " },
                lua = { icon = " " },
            },
        },
        messages = {
            enabled = true,
        },
        popupmenu = {
            enabled = true,
        },
        notify = {
            enabled = true, -- noice still uses nvim-notify for it's own messages
        },
        smart_move = {
            enabled = false,
        },
        lsp = {
            progress = {
                enabled = false,
            },
        },
        presets = {
            bottom_search = false, -- use a classic bottom cmdline for search
            command_palette = true, -- position the cmdline and popupmenu together
            long_message_to_split = true, -- long messages will be sent to a split
            inc_rename = false, -- enables an input dialog for inc-rename.nvim
            lsp_doc_border = true, -- add a border to hover docs and signature help
        },
        routes = {
            -- Note: %d -> for numbers | %a -> for alphanumeric | (.) -> for any except newline
            -- Note: adding `+` will extend this for one or more characters, ie: %a+%d+ | (.+)

            -- Remove notification for writing, deletion, and undo/redo operations

            {
                filter = {
                    event = "msg_show",
                    -- kind will remove all empty message kinds (doesn't work with nvim-dap when notify is enabled)
                    -- kind = ""
                    any = {
                        { find = "%d lines yanked" },           -- yanking
                        { find = "^/[^/]+" },                   -- searching
                        { find = "\"(.+)\" (.+) written" },     -- writing
                        { find = "; after #%d+" },              -- redo
                        { find = "; before #%d+" },             -- undo
                        { find = "%d fewer lines" },            -- deletion
                        { find = "%d more lines" },             -- paste
                    }
                },
                opts = { skip = true },
            },
            -- nvim-notify message filtering
            {
                filter = {
                    event = "notify",
                    any = {
                        -- Neotree
                        { find = "Toggling hidden files:" },
                        { find = "Cut (.+) to clipboard" },
                        { find = "Copied (.+) to clipboard" },
                        { find = "Renamed (.+) successfully" },
                        -- LSPConfig
                        { find = "No information available" },
                    }
                },
                opts = { skip = true },
            },
        }
    }

    -- needed if notify is used for transparent background
    ---@diagnostic disable-next-line: missing-fields
    require("notify").setup {
        background_colour = "#000000",
        stages = "no_animation"
    }
end

return M
