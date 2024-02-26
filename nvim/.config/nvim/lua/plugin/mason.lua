local M = {
    "williamboman/mason-lspconfig.nvim",
    event = "VeryLazy",
    dependencies = {
        "williamboman/mason.nvim",
    },
}

function M.config()
    -- Declare LSP tooling
    local servers = {
        "bashls",
        "cssls",
        "html",
        "jsonls",
        "lua_ls",
        "pyright",
        "terraformls",
        "tsserver",
        "yamlls",
    }
    local linters = {
        "shellcheck",
    }
    local formatters = {
        "black",
        "stylua",
        "prettier",
    }

    -- Concatenate lists
    local registry = require "mason-registry"
    local tools = vim.tbl_flatten { linters, formatters }


    -- MASON General Config
    require("mason").setup {
        ui = {
            border = "rounded",
        },
    }

    -- MASON LSP Config
    require("mason-lspconfig").setup {
        ensure_installed = servers
    }

    -- MASON Tooling
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
