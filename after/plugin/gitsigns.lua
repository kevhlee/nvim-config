local ok, gitsigns = pcall(require, 'gitsigns')
if not ok then
    return
end

gitsigns.setup {
    attach_to_untracked = true,
    max_file_length = 69420,
    current_line_blame_formatter = '<author>, <author_time:%Y-%m-%d> <abbrev_sha> - <summary>',
    current_line_blame_opts = {
        virt_text_pos = 'eol',
        delay = 1000,
        ignore_whitespace = false,
    },
    watch_gitdir = {
        interval = 500,
        follow_files = true,
    },
    preview_config = {
        border = 'single',
        style = 'minimal',
        relative = 'cursor',
    },
}

vim.keymap.set('n', '<leader>hp', '<cmd>Gitsigns preview_hunk<cr>')
vim.keymap.set('n', '<leader>hd', '<cmd>Gitsigns diffthis<cr>')
vim.keymap.set('n', '<leader>hj', '<cmd>Gitsigns next_hunk<cr>')
vim.keymap.set('n', '<leader>hk', '<cmd>Gitsigns prev_hunk<cr>')
vim.keymap.set('n', '<leader>hb', function()
    gitsigns.blame_line { full = true }
end)
