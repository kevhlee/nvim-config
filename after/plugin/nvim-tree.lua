local ok, plugin = pcall(require, 'nvim-tree')
if not ok then
    return
end

plugin.setup {
    hijack_netrw = false,
    hijack_cursor = true,
    open_on_setup = false,
    view = {
        side = 'left',
        adaptive_size = true,
        mappings = {
            list = {
                { key = 'r', action = 'full_rename' },
            },
        },
    },
    filters = {
        custom = {
            '.DS_Store',
            'node_modules/',
        },
    },
    update_focused_file = {
        enable = true,
        update_cwd = false,
    },
    git = {
        enable = true,
        ignore = false,
    },
    filesystem_watchers = { enable = true },
    renderer = {
        indent_markers = { enable = true },
        highlight_git = true,
    },
}

vim.keymap.set('n', '<C-n>', '<cmd>NvimTreeToggle<cr>')
vim.keymap.set('n', '<leader>n', '<cmd>NvimTreeFocus<cr>')
