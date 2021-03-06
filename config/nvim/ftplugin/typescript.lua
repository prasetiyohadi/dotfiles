local b = vim.b
local execute = vim.api.nvim_command

b["ale_fixers"] = { "prettier" }
b["ale_linters"] = { "eslint" }

execute([[
  augroup vimrc-typescript
    autocmd FileType typescript setlocal tabstop=2 shiftwidth=2 softtabstop=2 | setlocal expandtab
  augroup END
]])
