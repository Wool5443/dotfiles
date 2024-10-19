return
{
    'mfussenegger/nvim-dap',
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
                name = 'Launch',
                type = 'cpp', -- Match the adapter defined above
                request = 'launch',
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

        require('keys.alias')

        vim.fn.sign_define('DapBreakpoint', {text='🟥', texthl='', linehl='', numhl=''})

        Nm('<F9>', '<cmd>lua require\'dap\'.continue()<CR>')
        Nm('<F8>', '<cmd>lua require\'dap\'.step_over()<CR>')
        Nm('<F7>', '<cmd>lua require\'dap\'.step_into()<CR>')
        Nm('<S-F8>', '<cmd>lua require\'dap\'.step_out()<CR>')
        Nm('<Leader>b', '<cmd>lua require\'dap\'.toggle_breakpoint()<CR>')
        Nm('<Leader>B', '<cmd>lua require\'dap\'.set_breakpoint(vim.fn.input("Breakpoint condition: "))<CR>')
        Nm('<Leader>dr', '<cmd>lua require\'dap\'.repl.open()<CR>')
        Nm('<Leader>dl', '<cmd>lua require\'dap\'.run_last()<CR>')
    end
}
