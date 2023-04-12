-- Get the path to the Python 3 executable
local handle = io.popen("which python3")
local python_path = handle:read("*a")
handle:close()
python_path = string.gsub(python_path, "\n", "")


-- Set the vim.g.python3_host_prog variable
vim.g.loaded_python3_provider = 1
vim.g.python3_host_prog = python_path


-- Enable Providers
local enable_providers = {
      "python3_provider",
      "node_provider",
      -- and so on
    }

    for _, plugin in pairs(enable_providers) do
      vim.g["loaded_" .. plugin] = nil
      vim.cmd("runtime " .. plugin)
    end
