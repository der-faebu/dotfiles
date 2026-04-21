vim.cmd([[packadd packer.nvim]])

return require("packer").startup(function(use)
	-- Packer can manage itself
	use("nvim-tree/nvim-tree.lua")
	use("nvim-tree/nvim-web-devicons")
	use("wbthomason/packer.nvim")
	use("tpope/vim-fugitive")
	use("mbbill/undotree")
	-- use "folke/tokyonight.nvim"
	use("theprimeagen/harpoon")
	use("nvim-lua/plenary.nvim")
	use("tpope/vim-commentary")
	use("tpope/vim-repeat")
	use("tpope/vim-surround")
	-- use("iamcco/markdown-preview.nvim")
	use("mfussenegger/nvim-lint")
	use("lewis6991/gitsigns.nvim")
	use("christoomey/vim-tmux-navigator")

	use({
		"epwalsh/obsidian.nvim",
		tag = "*", -- recommended, use latest release instead of latest commit
		requires = {
			-- Required.
			"nvim-lua/plenary.nvim",

			-- see below for full list of optional dependencies 👇
		},
	})
	-- -- LSP
	--   use 'neovim/nvim-lspconfig'
	--   use 'williamboman/mason.nvim'
	--   use 'williamboman/mason-lspconfig.nvim'

	--Autocompletion
	use("hrsh7th/nvim-cmp")
	use("hrsh7th/cmp-buffer")
	use("hrsh7th/cmp-path")
	use("saadparwaiz1/cmp_luasnip")
	-- use 'hrsh7th/cmp-nvim-lsp'
	use("hrsh7th/cmp-nvim-lua")

	-- Snippets
	use("L3MON4D3/LuaSnip")
	use("rafamadriz/friendly-snippets")

	use({ "catppuccin/nvim", as = "catppuccin" })

	use({
		"nvim-lualine/lualine.nvim",
		requires = { "nvim-tree/nvim-web-devicons", opt = true },
	})
	--
	-- use({
	-- 	"render-markdown",
	-- 	after = { "nvim-treesitter" },
	-- 	requires = { "echasnovski/mini.nvim", opt = true }, -- if you use the mini.nvim suite
	-- 	requires = { "echasnovski/mini.icons", opt = true }, -- if you use standalone mini plugins
	-- 	requires = { "nvim-tree/nvim-web-devicons", opt = true }, -- if you prefer nvim-web-devicons
	-- })

	use({
		"s1n7ax/nvim-window-picker",
		tag = "v2.*",
		config = function()
			require("window-picker").setup()
		end,
	})

	use({
		"nvim-telescope/telescope.nvim",
		tag = "0.1.x",
		requires = { { "nvim-lua/plenary.nvim" } },
	})

    use { 'nvim-telescope/telescope-fzf-native.nvim', run = 'make' }

	use({
		"nvim-telescope/telescope-fzf-native.nvim",
		run = "cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release",
	})
    use {
      'aspeddro/pandoc.nvim',
      config = function()
        require'pandoc'.setup()
      end
    }

	-- use({
	-- 	"nvim-treesitter/nvim-treesitter",
	-- 	run = function()
	-- 		local ts_update = require("nvim-treesitter.install").update({ with_sync = true })
	-- 		ts_update()
	-- 	end,
	-- })
end)
