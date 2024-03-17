-- Buffer window is entered
vim.api.nvim_create_autocmd({ "BufWinEnter" }, {
    callback = function()
        -- removes comment auto-add, wrapping, and insert on "o"
        vim.cmd "set formatoptions-=cro"
    end,
})

-- With certain files (pattern)
vim.api.nvim_create_autocmd("FileType", {
    pattern = {
        "dapui-repl",
        "dapui_watches",
        "dapui_stacks",
        "dapui_breakpoints",
        "dapui_scopes",
    },
    callback = function()
        vim.cmd("setlocal nocursorline")
        -- local dapui = require("dapui")
    end,
})

-- With certain files (pattern)
vim.api.nvim_create_autocmd({ "FileType" }, {
    pattern = {
        "netrw",
        "Jaq",
        "qf",
        "git",
        "help",
        "man",
        "lspinfo",
        "oil",
        "spectre_panel",
        "lir",
        "DressingSelect",
        "tsplayground",
        "neotest-output-panel",
        "neotest-output",
        "",
    },
    callback = function()
        -- for the filetypes above sets close to "q"
        vim.cmd [[
      nnoremap <silent> <buffer> q :close<CR>
      set nobuflisted
    ]]
    end,
})

-- Command window is entered
vim.api.nvim_create_autocmd({ "CmdWinEnter" }, {
    callback = function()
        vim.cmd "quit"
    end,
})

-- Vim window is resized
vim.api.nvim_create_autocmd({ "VimResized" }, {
    callback = function()
        -- ensures that the layout remains balanced and adjusts the window sizes accordingly
        vim.cmd "tabdo wincmd ="
    end,
})

-- Buffer window is entered (for all files)
vim.api.nvim_create_autocmd({ "BufWinEnter" }, {
    pattern = { "*" },
    callback = function()
        -- ensures files are up to date
        vim.cmd "checktime"
    end,
})

-- Immedietly after a Yank
vim.api.nvim_create_autocmd({ "TextYankPost" }, {
    callback = function()
        -- makes it visually clear which text has been copied recently
        vim.highlight.on_yank { higroup = "Visual", timeout = 40 }
    end,
})

-- With certain Files (pattern)
vim.api.nvim_create_autocmd({ "FileType" }, {
    pattern = { "gitcommit", "markdown", "NeogitCommitMessage" },
    callback = function()
        -- wrapping enabled
        vim.opt_local.wrap = true
        -- spelling enabled
        vim.opt_local.spell = true
    end,
})

-- Start Lualine when neo-tree is open
vim.api.nvim_create_autocmd({ "FileType" }, {
    pattern = { "neo-tree", "NeogitStatus" },
    callback = function()
        -- wrapping enabled
        require("lualine")
    end,
})

-- Cursor hold event (for LUASNIP)
vim.api.nvim_create_autocmd({ "CursorHold" }, {
    callback = function()
        local status_ok, luasnip = pcall(require, "luasnip")
        if not status_ok then
            return
        end
        if luasnip.expand_or_jumpable() then
            -- ask maintainer for option to make this silent
            -- luasnip.unlink_current()
            vim.cmd [[silent! lua require("luasnip").unlink_current()]]
        end
    end,
})
