local g = vim.g

local function map(mode, lhs, rhs, opts)
	local options = { noremap = true }
	if opts then
		options = vim.tbl_extend("force", options, opts)
	end
	vim.api.nvim_set_keymap(mode, lhs, rhs, options)
end

g.rnvimr_enable_picker = 1

map("n", "<leader><Space>r", ":RnvimrToggle<CR>")
map("t", "<silent> <M-i>", "<C-\\><C-n>:RnvimrResize<CR>")
-- map("n", "<silent> <M-o>", ":RnvimrToggle<CR>")
map("t", "<silent> <M-o>", "<C-\\><C-n>:RnvimrToggle<CR>")
