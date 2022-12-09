local g = vim.g

g.floaterm_height = 0.3
g.floaterm_width = 0.6
g.floaterm_winblend = 0
g.floaterm_wintype = "split"

-- Floaterm mappings
vim.api.nvim_set_keymap("", "<leader>t", ":FloatermToggle<CR>", { noremap = true })
vim.api.nvim_set_keymap("!", "<leader>t", "<Esc>:FloatermToggle<CR>", { noremap = true })
vim.api.nvim_set_keymap("t", "<leader>t", "<C-\\><C-n>:FloatermToggle<CR>", { noremap = true })
