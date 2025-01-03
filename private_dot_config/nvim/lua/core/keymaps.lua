-- Navigate vim panes better
vim.keymap.set('n', '<c-k>', ':wincmd k<CR>')
vim.keymap.set('n', '<c-j>', ':wincmd j<CR>')
vim.keymap.set('n', '<c-h>', ':wincmd h<CR>')
vim.keymap.set('n', '<c-l>', ':wincmd l<CR>')

vim.keymap.set('n', '<leader>h', ':nohlsearch<CR>')

-- Visual mode binding to format selected text with Prettier
vim.api.nvim_set_keymap('v', '<leader>p', ":'<,'>Prettier<CR>", { noremap = true, silent = true })

-- Emmet expand abbreviation with Ctrl-Y, comma (default Emmet keybind)
vim.g.user_emmet_leader_key='<C-Y>'
