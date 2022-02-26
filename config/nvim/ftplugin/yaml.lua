local b = vim.b
local execute = vim.api.nvim_command

b["ale_fix_on_save"] = 0
b["ale_fixers"] = { "yamlfix" }
b["ale_linters"] = { "yamllint" }

execute([[
  augroup vimrc-yaml
    autocmd FileType yaml setlocal tabstop=2 shiftwidth=2 softtabstop=2 expandtab indentkeys-=0# indentkeys-=<:>
  augroup END
]])
