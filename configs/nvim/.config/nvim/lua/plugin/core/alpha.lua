local M = {
    "goolord/alpha-nvim",
    event = "VimEnter",
}

function M.config()
    local dashboard = require "alpha.themes.dashboard"
    local icons = require "user.icons"

    local function button(sc, txt, keybind, keybind_opts)
        local b = dashboard.button(sc, txt, keybind, keybind_opts)
        b.opts.hl_shortcut = "Include"
        return b
    end

    dashboard.section.header.val = {
        [[                                  __]],
        [[     ___     ___    ___   __  __ /\_\    ___ ___]],
        [[    / _ `\  / __`\ / __`\/\ \/\ \\/\ \  / __` __`\]],
        [[   /\ \/\ \/\  __//\ \_\ \ \ \_/ |\ \ \/\ \/\ \/\ \]],
        [[   \ \_\ \_\ \____\ \____/\ \___/  \ \_\ \_\ \_\ \_\]],
        [[    \/_/\/_/\/____/\/___/  \/__/    \/_/\/_/\/_/\/_/]],
        [[]],
        [[]],
        [[]],
    }

    dashboard.section.buttons.val = {
        button("n", icons.ui.NewFile .. " New file", ":ene <BAR> startinsert <CR>"),
        button("f", icons.ui.Files .. " Find file", ":Telescope find_files <CR>"),
        -- button("p", icons.git.Repo .. " Find project", ":lua require('telescope').extensions.projects.projects()<CR>"),
        -- button("r", icons.ui.History .. " Recent files", ":Telescope oldfiles <CR>"),
        button("s", icons.ui.Text .. " Find text", ":Telescope live_grep <CR>"),
        button("e", icons.ui.FolderSymlink .. " Filesystem", ":Neotree current <CR>"),
        button("g", icons.git.Octoface .. " Git", function() require("snacks").lazygit() end),
        button("d", icons.misc.Database .. " DBUI", ":tabnew | DBUI <CR>"),
        button("l", icons.ui.DebugConsole .. " Leet", ":Leet<CR>"),
        button("c", icons.ui.Gear .. " Config", ":e ~/.config/nvim/init.lua <CR>"),
        button("q", icons.ui.SignOut .. " Quit", ":qa<CR>"),
    }
    -- For Restoring a vim Session if a `.Session.vim` file exists (see vim Session autocmd in lua/init/autocmds.lua)
    if vim.fn.filereadable(vim.fn.expand('.Session.vim')) == 1 then
        local buttons = dashboard.section.buttons.val
        for i = #buttons, 1, -1 do
            buttons[i + 1] = buttons[i]
        end
        buttons[1] = button("S", icons.ui.BookMark .. "  Restore Session", ":source .Session.vim<CR>")
    end

    local function footer()
        return "samgabel.com"
    end

    dashboard.section.footer.val = footer()

    dashboard.section.header.opts.hl = "Keyword"
    dashboard.section.buttons.opts.hl = "Include"
    dashboard.section.footer.opts.hl = "Type"

    dashboard.opts.opts.noautocmd = true
    require("alpha").setup(dashboard.opts)

    vim.api.nvim_create_autocmd("User", {
        pattern = "LazyVimStarted",
        callback = function()
            local stats = require("lazy").stats()
            -- local ms = (math.floor(stats.startuptime * 100 + 0.5) / 100)
            -- dashboard.section.footer.val = "Loaded " .. stats.count .. " plugins in " .. ms .. "ms"
            dashboard.section.footer.val = "Loaded " .. stats.count .. " plugins "
            pcall(vim.cmd.AlphaRedraw)
        end,
    })

    vim.api.nvim_create_autocmd({ "User" }, {
        pattern = { "AlphaReady" },
        callback = function()
            vim.cmd [[
              set laststatus=0 | autocmd BufUnload <buffer> set laststatus=3
            ]]
        end,
    })
end

return M
