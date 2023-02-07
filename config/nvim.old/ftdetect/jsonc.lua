local execute = vim.api.nvim_command

execute([[
    autocmd BufNewFile,BufRead */.vscode/*.json set filetype=jsonc
]])
