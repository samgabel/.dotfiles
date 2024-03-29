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

    null_ls.setup {
        debug = false,
        sources = {
            formatting.stylua,
            -- formatting.prettier,
            -- formatting.prettier.with {
            --     extra_filetypes = { "toml", "yaml" },
            --     extra_args = { "--tab-width 2", "--no-semi", "--single-quote", "--jsx-single-quote" },
            -- },

        -- PYTHON --
            formatting.black,
            -- diagnostics (lspconfig) -> pyright

        -- JAVASCRIPT --
            -- formatting.eslint,

        -- GO --


        -- SHELL --
            -- formatting (lspconfig) -> bashls
            -- diagnostics (lspconfig) -> bashls

        -- ANSIBLE --
            -- formatting (lspconfig) -> ansiblels (not using ansible-line bc it's wack)
            -- diagnostics (lspconfig) -> ansiblels (not using ansible-line bc it's wack)

            -- null_ls.builtins.completion.spell,
        },
    }
end

return M
