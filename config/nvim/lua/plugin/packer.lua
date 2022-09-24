local fn = vim.fn

local function conf(plugin)
	return "require('plugin/" .. plugin .. "')"
end

-- Patch for Luarocks package installation in macOS BigSur
-- https://github.com/wbthomason/packer.nvim/issues/180
fn.setenv("MACOSX_DEPLOYMENT_TARGET", "10.15")

return require("packer").startup(function()
	-- Packer can manage itself
	use("wbthomason/packer.nvim")

	-- Simple plugins can be specified as strings
	-- use("9mm/vim-closer")
	-- use("ggandor/lightspeed.nvim")
	-- use("kevinoid/vim-jsonc")
	-- use("maxmellon/vim-jsx-pretty")
	-- use("preservim/vim-pencil")
	-- use("tsandall/vim-rego")
	-- use("dhruvasagar/vim-table-mode")
	-- use("mg979/vim-visual-multi")
	-- use("TaDaa/vimade")
	use("tpope/vim-commentary")
	use("tpope/vim-fugitive")
	-- use("tpope/vim-obsession")
	-- use("ryanoasis/vim-devicons")
	-- use("airblade/vim-gitgutter")
	-- use("JuliaEditorSupport/julia-vim")
	-- use("kdheepak/JuliaFormatter.vim")
	use("camspiers/lens.vim")
	-- use("preservim/nerdcommenter")
	-- use("easymotion/vim-easymotion")
	use("jiangmiao/auto-pairs")
	use("hashivim/vim-terraform")
	use("hrsh7th/vim-vsnip")
	use("cstrap/python-snippets")
	use("ylcnfrht/vscode-python-snippet-pack")
	use("xabikos/vscode-javascript")
	use("golang/vscode-go")
	use("rust-lang/vscode-rust")
	use("sbdchd/neoformat")
	use("glepnir/lspsaga.nvim")
	use("ray-x/lsp_signature.nvim")
	use("github/copilot.vim")

	-- Lazy loading:
	-- Load on specific commands
	use({ "tpope/vim-dispatch", opt = true, cmd = { "Dispatch", "Make", "Focus", "Start" } })

	-- Load on an autocommand event
	use({ "andymass/vim-matchup", event = "VimEnter" })

	-- Load on a combination of conditions: specific filetypes or commands
	-- Also run code after load (see the "config" key)
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

	-- Plugins can have dependencies on other plugins
	use({
		"nvim-telescope/telescope.nvim",
		config = conf("telescope"),
		requires = {
			"nvim-lua/plenary.nvim",
			{ "nvim-telescope/telescope-fzf-native.nvim", run = "make" },
			"nvim-telescope/telescope-file-browser.nvim",
		},
	})
	-- use({
	-- 	"jistr/vim-nerdtree-tabs",
	-- 	config = conf("nerdtree"),
	-- 	requires = "scrooloose/nerdtree",
	-- })
	-- use({
	-- 	"shougo/deoplete-lsp",
	-- 	opt = true,
	-- 	requires = { { "shougo/deoplete.nvim", config = conf("deoplete"), opt = true, run = ":UpdateRemotePlugins" } },
	-- })

	-- You can specify rocks in isolation
	use_rocks("luacheck")

	-- Plugins can have post-install/update hooks
	use({
		"iamcco/markdown-preview.nvim",
		run = "cd app && yarn install",
		cmd = "MarkdownPreview",
		ft = { "markdown", "vimwiki" },
	})
	use({ "kevinhwang91/rnvimr", config = conf("rnvimr"), run = "make sync" })

	-- Post-install/update hook with neovim command
	use({ "fatih/vim-go", run = ":GoInstallBinaries" })

	-- Post-install/update hook with call of vimscript function with argument
	-- use({ "junegunn/fzf.vim", requires = {
	-- 	"junegunn/fzf",
	-- 	run = function()
	-- 		vim.fn["fzf#install"]()
	-- 	end,
	-- } })
	use({
		"ojroques/nvim-lspfuzzy",
		run = function()
			require("lspfuzzy").setup()
		end,
	})
	use({ "morhetz/gruvbox", config = conf("gruvbox") })
	use({ "Yggdroot/indentLine", config = conf("indentLine") })
	use({ "pedrohdz/vim-yaml-folds", config = conf("vim-yaml-folds") })
	use({ "vimwiki/vimwiki", config = conf("vimwiki") })

	-- Use specific branch, dependency and run lua file after load
	use({
		"glepnir/galaxyline.nvim",
		branch = "main",
		config = conf("spaceline"),
		requires = { "kyazdani42/nvim-web-devicons" },
	})

	-- Use dependency and run lua function after load
	use({
		"lewis6991/gitsigns.nvim",
		requires = {
			"nvim-lua/plenary.nvim",
		},
		config = conf("gitsigns"),
	})
	use({
		"neovim/nvim-lspconfig",
		config = conf("lspconfig"),
	})
	use({
		"hrsh7th/nvim-compe",
		config = conf("compe"),
	})
	use({
		"voldikss/vim-floaterm",
		config = conf("floaterm"),
	})

	-- You can specify multiple plugins in a single call
	use({
		"tjdevries/colorbuddy.vim",
		{ "nvim-treesitter/nvim-treesitter", config = conf("nvim-treesitter"), run = ":TSUpdate" },
	})

	-- You can alias plugin names
	use({ "dracula/vim", as = "dracula" })
end)
