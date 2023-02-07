local b = vim.b
local execute = vim.api.nvim_command

b["ale_linters"] = { "golint" }
b["ale_fixers"] = { "gofmt", "goimports" }

execute([[
  augroup vimrc-go
    autocmd FileType go setlocal indentkeys-=0# indentkeys-=<:>
  augroup END
]])
