vim.api.nvim_command([[
  augroup vimrc-markdown
    autocmd FileType markdown setlocal tabstop=2 shiftwidth=2 softtabstop=2 expandtab indentkeys-=0# indentkeys-=<:>
  augroup END
  ]])
