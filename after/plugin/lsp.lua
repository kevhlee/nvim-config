local ok, lsp = pcall(require, 'lsp-zero')
if not ok then
    return
end

lsp.preset 'recommended'

lsp.set_preferences {
    suggest_lsp_servers = false,
    set_lsp_keymaps = false,
    configure_diagnostics = false,
}

lsp.ensure_installed {
    'gopls',
    'sumneko_lua',
    'tsserver',
    'vimls',
}

lsp.on_attach(function(_, bufnr)
    local lsp = vim.lsp
    local diagnostic = vim.diagnostic
    local function set_keymap(mode, lhs, rhs)
        vim.keymap.set(mode, lhs, rhs, { buffer = bufnr, noremap = true, silent = true })
    end

    set_keymap('n', 'K', lsp.buf.hover)
    set_keymap('n', '<C-k>', lsp.buf.signature_help)
    set_keymap('n', '<leader>gD', lsp.buf.declaration)
    set_keymap('n', '<leader>gd', '<cmd>Telescope lsp_definitions<cr>')
    set_keymap('n', '<leader>gi', '<cmd>Telescope lsp_implementations<cr>')
    set_keymap('n', '<leader>gr', '<cmd>Telescope lsp_references<cr>')
    set_keymap('n', '<leader>gt', '<cmd>Telescope lsp_type_definitions<cr>')
    set_keymap('n', '<leader>dl', '<cmd>Telescope diagnostics<cr>')
    set_keymap('n', '<leader>do', diagnostic.open_float)
    set_keymap('n', '<leader>dk', diagnostic.goto_prev)
    set_keymap('n', '<leader>dj', diagnostic.goto_next)
    set_keymap('n', '<leader>ca', lsp.buf.code_action)
    set_keymap('n', '<leader>cr', lsp.buf.rename)
    set_keymap('n', '<leader>cf', lsp.buf.format)
end)

lsp.configure('sumneko_lua', {
    settings = {
        Lua = {
            diagnostics = {
                globals = { 'use', 'vim' },
            },
            workspace = {
                library = {
                    [vim.fn.expand '$VIMRUNTIME/lua'] = true,
                    [vim.fn.expand '$VIMRUNTIME/lua/vim/lsp'] = true,
                },
            },
        },
    },
})

lsp.configure 'ocamllsp'

lsp.setup()
