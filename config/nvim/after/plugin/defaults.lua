-- [[ Setting options ]]
-- See `:help vim.o`

-- Make relative line numbers default
vim.wo.relativenumber = true

-- Do not save undo history
vim.o.undofile = false

-- Configure filetype
vim.cmd([[filetype plugin indent on]])

-- Configure conceal level
vim.opt.conceallevel = 2

-- Configure folding
vim.opt.foldenable = false

-- Encoding
vim.opt.encoding = "utf-8" -- set default encoding to UTF-8
vim.opt.fileencoding = "utf-8"
vim.opt.fileencodings = "utf-8"

-- Fix backspace indent
vim.opt.backspace = "indent,eol,start"

-- Visual settings
vim.cmd([[syntax on]])
