local ok_dap, dap = pcall(require, 'dap')
if not ok_dap then
    return
end

vim.keymap.set('n', '<leader>bs', dap.continue)
vim.keymap.set('n', '<leader>br', dap.restart)
vim.keymap.set('n', '<leader>bl', dap.step_over)
vim.keymap.set('n', '<leader>bj', dap.step_into)
vim.keymap.set('n', '<leader>bk', dap.step_out)
vim.keymap.set('n', '<leader>bt', dap.terminate)
vim.keymap.set('n', '<leader>bc', dap.toggle_breakpoint)
vim.keymap.set('n', '<leader>bC', function()
    dap.toggle_breakpoint(vim.fn.input 'Breakpoint condition: ')
end)

-- ##
-- ## Go
-- ##

dap.adapters.delve = {
    type = 'server',
    port = '${port}',
    executable = {
        command = 'dlv',
        args = { 'dap', '-l', '127.0.0.1:${port}' },
    },
}

dap.configurations.go = {
    {
        type = 'delve',
        name = 'Debug',
        request = 'launch',
        program = '${file}',
    },
    {
        type = 'delve',
        name = 'Debug test',
        request = 'launch',
        mode = 'test',
        program = '${file}',
    },
    {
        type = 'delve',
        name = 'Debug test (go.mod)',
        request = 'launch',
        mode = 'test',
        program = './${relativeFileDirname}',
    },
}

-- ##
-- ## Scala
-- ##

dap.configurations.scala = {
    {
        type = 'scala',
        request = 'launch',
        name = 'Run Or Test Target',
        metals = {
            runType = 'runOrTestFile',
            args = {},
        },
    },
    {
        type = 'scala',
        request = 'launch',
        name = 'Test Target',
        metals = {
            runType = 'testTarget',
        },
    },
}

local ok_ui, ui = pcall(require, 'dapui')
if not ok_ui then
    return
end

ui.setup {
    layouts = {
        {
            elements = {
                'scopes',
                'breakpoints',
                'stacks',
                'watches',
            },
            size = 40,
            position = 'left',
        },
        {
            elements = {
                'repl',
                'console',
            },
            size = 10,
            position = 'bottom',
        },
    },
}

vim.keymap.set('n', '<leader>bb', ui.toggle)
