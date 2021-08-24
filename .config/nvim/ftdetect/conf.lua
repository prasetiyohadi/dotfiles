local execute = vim.api.nvim_command

execute('autocmd BufNewFile,BufRead *.conf set filetype=dosini')
