local execute = vim.api.nvim_command
local g = vim.g

execute('autocmd FileType julia nnoremap <buffer> <c-f> :JuliaFormatterFormat<cr>')

g.JuliaFormatter_options = {
  indent = 4,
  margin = 92,
  always_for_in = 0,
  whitespace_typedefs = 0,
  whitespace_ops_in_indices = 1
}
