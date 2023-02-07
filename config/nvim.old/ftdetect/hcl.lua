local execute = vim.api.nvim_command

execute("autocmd BufNewFile,BufRead *.hcl set filetype=terraform")
