local execute = vim.api.nvim_command
local g = vim.g

g.NERDTreeShowHidden = 1
g.NERDTreeMinimalUI = 1
g.NERDTreeIgnore = {}
g.NERDTreeStatusline = ""

-- Automaticaly close nvim if NERDTree is only thing left open'
execute('autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif')
