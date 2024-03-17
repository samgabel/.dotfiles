local M = {
    "mfussenegger/nvim-dap",
    lazy = true,
}

function M.config()

    local wk = require "which-key"
    wk.register {
        ["<leader>dK"] = { "<CMD>lua require('dapui').eval()<CR><CMD>lua require('dapui').eval()<CR>", "Expression Float" },
        ["<leader>db"] = { "<CMD>DapToggleBreakpoint<CR>", "Breakpoint" },
        ["<leader>dc"] = { "<CMD>DapContinue<CR>", "Continue" },
        ["<leader>do"] = { "<CMD>DapStepOver<CR>", "Step Over" },
        ["<leader>di"] = { "<CMD>DapStepInto<CR>", "Step Into" },
        ["<leader>dO"] = { "<CMD>DapStepOut<CR>", "Step Out" },
        ["<leader>dq"] = { "<CMD>DapTerminate<CR>", "Quit" },
        -- PYTHON SPECIFIC
        ["<leader>dpr"] = {
            function()
                require("dap-python").test_method()
            end,
            "Test Method"
        },
    }

    local dap = require("dap")

    -- dap.configurations.dap_repl = {
    --
    -- }

    dap.configurations.python = {
        ---@diagnostic disable-next-line: missing-fields
        {
            justMyCode = false
        }
    }

end

return M

