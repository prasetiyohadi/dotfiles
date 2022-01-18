local cmd = vim.cmd
local g = vim.g
local opt = vim.opt

----- Basic Setup -----
cmd("filetype plugin indent on")
cmd("colorscheme gruvbox")

-- Encoding
opt.encoding = "utf-8" -- set default encoding to UTF-8
opt.fileencoding = "utf-8"
opt.fileencodings = "utf-8"

-- Fix backspace indent
opt.backspace = "indent,eol,start"

-- Tabs. May be overridden by autocmd rules
opt.expandtab = true -- use spaces instead of tabs
opt.shiftwidth = 4 -- size of an indent
opt.softtabstop = 0
opt.tabstop = 4 -- number of spaces tabs count for

-- Map leader to ,
g["mapleader"] = ","

-- Enable hidden buffers
opt.hidden = true -- enable background buffers

-- Searching
opt.hlsearch = true -- highlight found searches
opt.ignorecase = true -- ignore case
opt.incsearch = true -- shows the match while typing
opt.smartcase = true -- do not ignore case with capitals

opt.fileformats = "unix,dos,mac"

-- session management
g["session_directory"] = "~/.config/nvim/session"
g["session_autoload"] = "no"
g["session_autosave"] = "no"
g["session_command_aliases"] = 1

-- Visual settings
cmd("syntax on")

opt.number = true -- show line numbers
opt.ruler = true

g["no_buffers_menu"] = 1

opt.gfn = "Monospace 10"
opt.mousemodel = "popup"

-- Disable the blinking cursor.
opt.gcr = "a:blinkon0"

cmd("au TermEnter * setlocal scrolloff=0")
cmd("au TermLeave * setlocal scrolloff=3")

-- Status bar
opt.laststatus = 2

-- Use modeline overrides
opt.modeline = true
opt.modelines = 10

opt.title = true
opt.titleold = "Terminal"
opt.titlestring = "%F"

opt.statusline = "%F%m%r%h%w%=(%{&ff}/%Y) (line %l/%L, col %c)"

-- Custom
opt.completeopt = "menuone,noselect" -- completion options (for deoplete)
opt.cursorline = true
opt.ff = "unix"
opt.foldenable = false
opt.foldmethod = "indent"
opt.formatoptions = "l"
opt.inccommand = "split" -- Get a preview of replacements
opt.joinspaces = false -- no double spaces with join
opt.linebreak = true -- stop words being broken on wrap
opt.list = true -- show some invisible characters
opt.numberwidth = 5 -- make the gutter wider by default
opt.relativenumber = true -- relative line numbers
opt.scrolloff = 4 -- lines of context
opt.shiftround = true -- round indent
opt.showmode = false -- don't display mode
opt.sidescrolloff = 8 -- columns of context
opt.signcolumn = "yes:1" -- always show signcolumns
opt.smartindent = true -- insert indents automatically
opt.spelllang = "en"
opt.splitbelow = true -- put new windows below current
opt.splitright = true -- put new windows right of current
opt.termguicolors = true -- true color support
opt.updatetime = 250 -- don't give |ins-completion-menu| messages
-- opt.wildmode = {'list', 'longest'}    -- command-line completion mode
opt.wrap = true -- enable line wrap
