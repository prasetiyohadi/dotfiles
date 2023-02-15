return function(use)
	local function conf(plugin)
		return "require('custom/" .. plugin .. "')"
	end

	use({
		"folke/which-key.nvim",
		config = function()
			vim.o.timeout = true
			vim.o.timeoutlen = 500
			require("which-key").setup({})
		end,
	})
	use("hashivim/vim-terraform")
	use({
		"dense-analysis/ale",
		ft = {
			"sh",
			"zsh",
			"bash",
			"c",
			"cpp",
			"cmake",
			"html",
			"markdown",
			"racket",
			"vim",
			"tex",
			"yaml",
			"dockerfile",
			"terraform",
			"lua",
			"go",
			"json",
			"typescript",
			"python",
		},
		cmd = "ALEEnable",
		config = { conf("ale"), "vim.cmd[[ALEEnable]]" },
	})
end
