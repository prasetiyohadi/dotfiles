local b = vim.b
local execute = vim.api.nvim_command

b["ale_fixers"] = { "black" }
b["ale_linters"] = { "pylint" }

execute([[
  augroup vimrc-python
    autocmd FileType python setlocal expandtab shiftwidth=4 tabstop=8
    | setlocal colorcolumn=79 formatoptions+=croq softtabstop=4 smartindent
    | setlocal cinwords=if,elif,else,for,while,try,except,finally,def,class,with
  augroup END
]])
