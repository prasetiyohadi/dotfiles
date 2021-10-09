local actions = require("telescope.actions")

local function map(mode, lhs, rhs, opts)
	local options = { noremap = true }
	if opts then
		options = vim.tbl_extend("force", options, opts)
	end
	vim.api.nvim_set_keymap(mode, lhs, rhs, options)
end

require("telescope").setup({
	defaults = {
		winblend = 20,
		sorting_strategy = "descending",
		layout_strategy = "horizontal",
		layout_config = {
			horizontal = {
				mirror = false,
			},
			vertical = {
				mirror = false,
			},
		},
		mappings = {
			i = {
				["<esc>"] = actions.close,
			},
		},
	},
	extensions = {
		fzf = {
			fuzzy = true, -- false will only do exact matching
			override_generic_sorter = false, -- override the generic sorter
			override_file_sorter = true, -- override the file sorter
			case_mode = "smart_case", -- or "ignore_case" or "respect_case"
			-- the default case_mode is "smart_case"
		},
	},
	pickers = {
		buffers = {
			sort_lastused = true,
			mappings = {
				i = {
					["<C-w>"] = "delete_buffer",
				},
				n = {
					["<C-w>"] = "delete_buffer",
				},
			},
		},
	},
})

-- To get fzf loaded and working with telescope, you need to call
-- load_extension, somewhere after setup function:
require("telescope").load_extension("fzf")

-- Mappings
-- <leader>ff: find_files
map(
	"n",
	"<leader>ff",
	--'<cmd>lua require("telescope.builtin").find_files(require("telescope.themes").get_dropdown({}))<cr>'
	'<cmd>lua require("telescope.builtin").find_files()<cr>'
)
-- <leader>fg: live_grep
map(
	"n",
	"<leader>fg",
	--'<cmd>lua require("telescope.builtin").live_grep(require("telescope.themes").get_dropdown({}))<cr>'
	'<cmd>lua require("telescope.builtin").live_grep()<cr>'
)
-- <leader>fb: buffers
map(
	"n",
	"<leader>fb",
	--'<cmd>lua require("telescope.builtin").buffers(require("telescope.themes").get_dropdown({}))<cr>'
	'<cmd>lua require("telescope.builtin").buffers()<cr>'
)
-- <leader>fh: help_tags
map("n", "<leader>fh", '<cmd>lua require("telescope.builtin").help_tags()<cr>')
-- <leader>fs: file_browser
map(
	"n",
	"<leader>fs",
	'<cmd>lua require("telescope.builtin").file_browser(require("telescope.themes").get_dropdown({}))<cr>'
)
-- <leader>fr: registers
map("n", "<leader>fr", '<cmd>lua require("telescope.builtin").registers()<cr>')
-- <leader>fp: spell_suggest
map("n", "<leader>fp", '<cmd>lua require("telescope.builtin").spell_suggest()<cr>')
-- <leader>fi: git_status
map(
	"n",
	"<leader>fi",
	'<cmd>lua require("telescope.builtin").git_status(require("telescope.themes").get_dropdown({}))<cr>'
)
