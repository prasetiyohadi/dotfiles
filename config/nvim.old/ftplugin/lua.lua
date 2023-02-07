local b = vim.b
local execute = vim.api.nvim_command

b["ale_fixers"] = { "stylua" }
b["ale_linters"] = { "luacheck" }

execute("autocmd FileType lua set tabstop=4|set softtabstop=4|set shiftwidth=2 noexpandtab")

if b.expandtab then
	b.tabstop = 4
end
