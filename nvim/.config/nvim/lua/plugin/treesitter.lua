local M = {
    "nvim-treesitter/nvim-treesitter",
    event = { "BufReadPost", "BufNewFile" },
    build = ":TSUpdate",
}

function M.config()
    ---@diagnostic disable-next-line: missing-fields
    require("nvim-treesitter.configs").setup {
        ensure_installed = {
            "markdown",
            "markdown_inline",
            -- WEB
            "html",
            "css",
            -- CONFIG
            "json",
            "yaml",
            "toml",
            "terraform",
            "make",
            -- PROGRAMMING
            "bash",
            "lua",
            "python",
            "go",
            "javascript",
            "typescript",
            "rust",
        },
        highlight = { enable = true },
        indent = { enable = true },
    }
end

return M
