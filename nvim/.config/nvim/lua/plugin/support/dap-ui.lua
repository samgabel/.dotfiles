local M = {
    "rcarriga/nvim-dap-ui",
    lazy = true,
    dependencies = {
        {
            "mfussenegger/nvim-dap",
            "LiadOz/nvim-dap-repl-highlights",
        },
    }
}

function M.config()

    ---@diagnostic disable-next-line: missing-fields
    require("dapui").setup({
        layouts = {
            {
                elements = {
                    { id = "scopes", size = 0.35 },
                    { id = "breakpoints", size = 0.15 },
                    { id = "stacks", size = 0.15 },
                    { id = "watches", size = 0.35 },
                },
                position = "right",
                size = 0.01
            },
            {
                elements = {
                    { id = "repl", size = 0.5 },
                    -- { id = "console", size = 0.5 }
                },
                position = "bottom",
                size = 8
            }
        },
    })

    local neotest = require("neotest")

    -- DAP UI EVENTS
    local dap, dapui = require("dap"), require("dapui")
    -- dap.listeners.before.attach.dapui_config = function()
    --     dapui.open()
    -- end
    dap.listeners.before.launch.dapui_config = function()
        neotest.summary.close()
        dapui.open()
    end
    dap.listeners.before.event_terminated.dapui_config = function()
        neotest.summary.open()
        dapui.close()
    end
    dap.listeners.before.event_exited.dapui_config = function()
        dapui.close()
    end

end

return M

