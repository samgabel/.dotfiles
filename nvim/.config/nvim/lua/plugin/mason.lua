local M = {
    "williamboman/mason-lspconfig.nvim",
    event = "VeryLazy",
    dependencies = {
        "williamboman/mason.nvim",
    },
}

function M.config()

    -- DECLARE PACKAGES --------------------------------------------------------------

    -- SERVER list --
    local servers = {
        "ansiblels",
        "bashls",
        "cssls",
        "html",
        "jsonls",
        "lua_ls",
        "pyright",
        "gopls",
        "terraformls",
        "tsserver",
        "yamlls",
    }
    -- LINTER list --
    local linters = {
        -- "shellcheck",  <-- issue continually stacking `shellcheck` processes when entering .sh file
        -- "ansible-lint",  <-- currently a piece of doodoo
    }
    -- FORMATTER list --
    local formatters = {
        "black",        -- python
        "stylua",       -- lua
        "prettier",     -- combo
    }


    -- MASON General Config
    require("mason").setup {
        ui = {
            border = "rounded",
        },
    }


    -- INSTALLING PACKAGES ----------------------------------------------------------

    -- MASON LSP Config [install]
    require("mason-lspconfig").setup {
        ensure_installed = servers
    }

    -- Concatenate tooling lists
    local registry = require "mason-registry"
    local tools = vim.tbl_flatten { linters, formatters }

    -- MASON Tooling [install]
    registry.refresh(function ()
        for _, tool in ipairs(tools) do
            local pkg = registry.get_package(tool)
            if not pkg:is_installed() then
                pkg:install()
            end
        end
    end)


end

return M
