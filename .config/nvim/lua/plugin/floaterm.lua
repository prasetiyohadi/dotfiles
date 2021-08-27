local g = vim.g

g.floaterm_width = 100
g.floaterm_winblend = 0

-- Floaterm mappings
vim.api.nvim_set_keymap('', '<leader>t', ':FloatermToggle<CR>', {noremap = true})
vim.api.nvim_set_keymap('!', '<leader>t', '<Esc>:FloatermToggle<CR>', {noremap = true})
vim.api.nvim_set_keymap('t', '<leader>t', '<C-\\><C-n>:FloatermToggle<CR>', {noremap = true})
