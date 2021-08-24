local b = vim.b
local execute = vim.api.nvim_command

b['ale_fixers'] = {'prettier'}
b['ale_linters'] = {'yamllint'}

execute([[
augroup vimrc-yaml
autocmd FileType yaml setlocal tabstop=2 shiftwidth=2 softtabstop=2 expandtab
augroup END
]])
