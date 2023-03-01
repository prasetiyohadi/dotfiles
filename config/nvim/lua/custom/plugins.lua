return function(use)
	local function conf(plugin)
		return "require('custom/" .. plugin .. "')"
	end

	-- Syntax checking
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
	-- Keybinding popup
	use({
		"folke/which-key.nvim",
		config = function()
			vim.o.timeout = true
			vim.o.timeoutlen = 500
			require("which-key").setup({})
		end,
	})
	-- Markdown preview
	use({
		"iamcco/markdown-preview.nvim",
		run = "cd app && yarn install",
		cmd = "MarkdownPreview",
		ft = { "markdown", "vimwiki" },
	})
	-- Auto completion
	use({ "hrsh7th/nvim-compe", config = conf("compe") })
	-- Floating terminal
	use({ "voldikss/vim-floaterm", config = conf("floaterm") })
	-- Go development
	use({ "fatih/vim-go", run = ":GoInstallBinaries" })
	-- Text filtering and alignment
	use("godlygeek/tabular")
	-- Snippet engine
	use("SirVer/ultisnips")
	-- Snippet collections
	use("honza/vim-snippets")
	-- Auto close brackets
	use("jiangmiao/auto-pairs")
	-- Markdown Vim module
	use("ixru/nvim-markdown")
	-- Basic Terraform integration
	use("hashivim/vim-terraform")
end
