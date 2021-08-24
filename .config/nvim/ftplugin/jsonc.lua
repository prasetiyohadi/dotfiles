local execute = vim.api.nvim_command

execute([[
  augroup vimrc-jsonc
    autocmd!
    autocmd BufRead,BufNewFile *.mycjson set filetype=jsonc
  augroup END
]])
