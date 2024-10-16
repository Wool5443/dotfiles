return
{
    "mfussenegger/nvim-dap",
    config = function()
        local dap = require('dap')
        dap.adapters.cpp = {
            type = 'executable',
            command = '/usr/bin/gdb', -- Adjust this path if necessary
            name = 'cpp',
        }

        -- Set up DAP configurations for C++
        dap.configurations.cpp = {
            {
                name = "Launch",
                type = "cpp", -- Match the adapter defined above
                request = "launch",
                program = function()
                    return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')
                end,
                cwd = '${workspaceFolder}',
                stopOnEntry = false,
                setupCommands = {
                    {
                        text = '-enable-pretty-printing',
                        description = 'Enable pretty printing',
                        ignoreFailures = false
                    },
                },
            }
        }
    end
}
