local g = vim.g

g.floaterm_height = 0.33
g.floaterm_width = 0.99
g.floaterm_winblend = 0
g.floaterm_wintype = "float"
g.floaterm_position = "bottom"
g.floaterm_opener = "vsplit"
g.floaterm_keymap_new = "<F7>"
g.floaterm_keymap_prev = "<F8>"
g.floaterm_keymap_next = "<F9>"
g.floaterm_keymap_toggle = "<F12>"

-- Floaterm mappings
vim.api.nvim_set_keymap("", "<leader>t", ":FloatermToggle<CR>", { noremap = true })
vim.api.nvim_set_keymap("c", "<leader>t", "<Esc>:FloatermToggle<CR>", { noremap = true })
vim.api.nvim_set_keymap("t", "<leader>t", "<C-\\><C-n>:FloatermToggle<CR>", { noremap = true })

-- Floaterm commands
-- Integration: FZF (deprecated)
-- Use junnegun/fzf.vim instead
-- vim.api.nvim_create_user_command(
-- 	"FZF",
-- 	"FloatermNew --wintype=float --position=center --width=0.8 --height=0.8 fzf",
-- 	{}
-- )
-- Integration: Lazygit
vim.api.nvim_create_user_command(
	"Lg",
	"FloatermNew --wintype=float --position=center --width=0.8 --height=0.8 lazygit",
	{}
)
-- Integration: Ripgrep
vim.api.nvim_create_user_command(
	"Rg",
	"FloatermNew --wintype=float --position=center --width=0.8 --height=0.8 rg ''",
	{}
)
-- Integration: LF (deprecated)
-- Use ptzz/lf.vim instead
-- vim.api.nvim_create_user_command("LF", "FloatermNew --wintype=float --position=center --width=0.8 --height=0.8 lf", {})
-- Plugin: fzf-floaterm
vim.api.nvim_create_user_command("FTs", "Floaterms", {})
