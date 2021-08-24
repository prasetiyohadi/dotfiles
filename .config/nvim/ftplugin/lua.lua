local b = vim.b
local execute = vim.api.nvim_command

b['ale_fixers'] = {'stylua'}
b['ale_linters'] = {'luacheck'}

execute('autocmd FileType lua set tabstop=2|set softtabstop=2|set shiftwidth=2 expandtab')
if b.expandtab then b.tabstop = 2 end
