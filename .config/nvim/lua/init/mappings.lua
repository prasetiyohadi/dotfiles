local function map(mode, lhs, rhs, opts)
  local options = {noremap = true}
  if opts then options = vim.tbl_extend('force', options, opts) end
  vim.api.nvim_set_keymap(mode, lhs, rhs, options)
end

----- Mappings -----
-- All modes
map('', '<C-l>', ':Buffers<CR>')  -- Maps display of current buffers
map('', '<leader>c', '"+y') -- Copy to clipboard in normal, visual, select and operator modes

-- Insert mode
map('i', '<C-w>', '<C-g>u<C-w>')  -- Make <C-w> undo-friendly
map('i', '<C-u>', '<C-g>u<C-u>')  -- Make <C-u> undo-friendly

-- Normal mode
map('n', '<C-g>', ':Rg<CR>') -- Maps ripgrep file searching function
map('n', '<C-q>', ':qa<CR>') -- Maps quit all
map('n', '<leader><BS>', '<cmd>noh<CR>') -- Maps deselects currently highlighted searches
map('n', '<leader>o', 'm`o<Esc>``') -- Insert a newline in normal mode
map('n', '<leader>q', ':q<CR>') -- Maps quit
map('n', '<space>w', ':w<CR>')  -- Maps write
