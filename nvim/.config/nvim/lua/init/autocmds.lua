-- Buffer window is entered
vim.api.nvim_create_autocmd({ "BufWinEnter" }, {
    callback = function()
        -- removes comment auto-add, wrapping, and insert on "o"
        vim.cmd "set formatoptions-=cro"
        -- need to run breadcrumbs on buf enter if not lazy loading with lazy.nvim
        -- require("plugin.core.breadcrumbs.init").setup()
    end,
})

-- Neo-Tree lazily highjack netrw
vim.api.nvim_create_autocmd('BufEnter', {
    -- make a group to be able to delete it later
    group = vim.api.nvim_create_augroup('NeoTreeInit', {clear = true}),
    callback = function()
        local f = vim.fn.expand('%:p')
        if vim.fn.isdirectory(f) ~= 0 then
            vim.cmd('Neotree current dir=' .. f)
            -- neo-tree is loaded now, delete the init autocmd
            vim.api.nvim_clear_autocmds{group = 'NeoTreeInit'}
        end
    end
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
        "neotest-summary",
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

-- Highjack quickfix list with trouble
-- https://github.com/folke/trouble.nvim/issues/70#issuecomment-1848347986
vim.api.nvim_create_autocmd({ "FileType" }, {
    pattern = {
        "qf",
    },
    callback = function()
        local status_ok, trouble = pcall(require, "trouble")
        if status_ok then
            -- Check whether we deal with a quickfix or location list buffer, close the window and open the
            -- corresponding Trouble window instead.
            if vim.fn.getloclist(0, { filewinid = 1 }).filewinid ~= 0 then
                vim.defer_fn(function()
                    vim.cmd.lclose()
                    trouble.open("loclist")
                end, 0)
            else
                vim.defer_fn(function()
                    vim.cmd.cclose()
                    trouble.open("quickfix")
                end, 0)
            end
        end
    end,
})

-- Set highlight line in trouble
vim.api.nvim_create_autocmd({ "FileType" }, {
    pattern = {
        "Trouble",
        "Outline"
    },
    callback = function()
        -- inserts cursorline into trouble list
        vim.cmd [[ set cursorlineopt=line ]]
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

-- YANK highlight and duration --
vim.api.nvim_create_autocmd({ "TextYankPost" }, {
    callback = function()
        -- makes it visually clear which text has been copied recently
        vim.highlight.on_yank { higroup = "lualine_a_visual", timeout = 150 }
    end,
})

-- Start Lualine when neo-tree is open
vim.api.nvim_create_autocmd({ "FileType" }, {
    pattern = { "neo-tree", "NeogitStatus", "leetcode.nvim" },
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
