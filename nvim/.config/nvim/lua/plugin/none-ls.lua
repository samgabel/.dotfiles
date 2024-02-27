local M = {
    "nvimtools/none-ls.nvim",
    event = "VeryLazy",
    dependencies = {
        "nvim-lua/plenary.nvim",
    },
}

function M.config()
    local null_ls = require "null-ls"

    local formatting = null_ls.builtins.formatting
    local diagnostics = null_ls.builtins.diagnostics
    local code_actions = null_ls.builtins.code_actions

    -- TODO: formatting on <leader>le
    null_ls.setup {
        debug = false,
        sources = {
            formatting.stylua,
            formatting.prettier,
            formatting.prettier.with {
                extra_filetypes = { "toml", "yaml" },
                -- extra_args = { "--no-semi", "--single-quote", "--jsx-single-quote" },
            },

        -- SHELL --
            -- formatting (lspconfig) -> bashls
            -- diagnostics (lspconfig) -> bashls

        -- PYTHON --
            formatting.black,
            -- diagnostics (lspconfig) -> pyright
            -- code_actions (lspconfig) -> pyright

        -- JAVASCRIPT --
            -- formatting.eslint,


            -- null_ls.builtins.completion.spell,
        },
    }
end

return M
