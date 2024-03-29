local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"https://github.com/folke/lazy.nvim.git",
		"--branch=stable",
		lazypath,
	})
end
vim.opt.rtp:prepend(lazypath)

local lazy_ok, lazy = pcall(require, "lazy")
if not lazy_ok then
	return
end

lazy.setup({

	{ "folke/lazy.nvim" },

	{
		"folke/which-key.nvim",
		{ "folke/neoconf.nvim", cmd = "Neoconf" },
		"folke/neodev.nvim",
	},

	-- Post-install/update hook with neovim command
	{ "nvim-treesitter/nvim-treesitter", lazy = true },

	-- fugitive
	{ "tpope/vim-fugitive" },

	{
		"nvim-treesitter/nvim-treesitter-context",
		lazy = false,
		config = function()
			local ctx_ok, ctx = pcall(require, "treesitter-context")
			if not ctx_ok then
				return
			end
			ctx.setup({
				enable = true,
				max_lines = 0,
				min_window_height = 0,
				line_numbers = true,
				multiline_threshold = 20,
				trim_scope = "outer",
				mode = "cursor",
				separator = nil,
				zindex = 20,
				on_attach = nil,
			})
		end,
	},

	-- Use dependency and run lua function after load
	{
		"lewis6991/gitsigns.nvim",
		dependencies = { "nvim-lua/plenary.nvim" },
		config = function()
			local gitsigns_ok, gitsigns = pcall(require, "gitsigns")
			if not gitsigns_ok then
				return
			end

			-- gitsigns setup
			gitsigns.setup()
		end,
	},

	-- Telescope
	{
		"nvim-telescope/telescope.nvim",
		-- tag = "0.1.1",
		lazy = false,
		dependencies = {
			{ "nvim-lua/plenary.nvim" },
			{ "nvim-telescope/telescope-symbols.nvim" },
			{ "nvim-telescope/telescope-ui-select.nvim" },
		},
	},

	-- LSP
	{
		"VonHeikemen/lsp-zero.nvim",
		branch = "v3.x",
		lazy = false,
		dependencies = {
			-- LSP Support
			{ "neovim/nvim-lspconfig" }, -- Required

			{
				-- Optional
				"williamboman/mason.nvim",
				lazy = false,
				build = function()
					pcall(vim.cmd, "MasonUpdate")
				end,
			},

			-- TreeSitter ASM Highlighting
			{ "rush-rs/tree-sitter-asm" },

			{ "williamboman/mason-lspconfig.nvim" }, -- Optional

			-- Autocompletion
			{ "hrsh7th/nvim-cmp" }, -- Required
			{ "hrsh7th/cmp-nvim-lsp" }, -- Required
			{ "L3MON4D3/LuaSnip" }, -- Required

			-- NullLs
			{
				"jose-elias-alvarez/null-ls.nvim",
				dependencies = { "nvim-lua/plenary.nvim" },
			},

			-- Autopair
			{
				"windwp/nvim-autopairs",
				config = function()
					local ok, autopair = pcall(require, "nvim-autopairs")
					if not ok then
						return
					end

					autopair.setup()
				end,
			},
		},
	},

	-- Comment
	{
		"numToStr/Comment.nvim",
		config = function()
			require("Comment").setup()
		end,
	},

	-- Indent blankline
	{
		"lukas-reineke/indent-blankline.nvim",
		config = function()
			require("kradlus.plugins.indent-blankline")
		end,
	},

	-- lualine
	{
		"nvim-lualine/lualine.nvim",
		dependencies = { "nvim-tree/nvim-web-devicons", lazy = false },
		config = function()
			pcall(require, "kradlus.plugins.lualine")
		end,
		lazy = false,
	},

	-- LazyGit
	{
		"kdheepak/lazygit.nvim",
		-- optional for floating window border decoration
		dependencies = {
			"nvim-lua/plenary.nvim",
		},
		lazy = false,
	},

	-- Markdown preview
	{
		"iamcco/markdown-preview.nvim",
		build = "cd app && yarn install",
		lazy = false,
	},

	-- nim
	{
		"alaviss/nim.nvim",
		name = "nim",
		dependencies = {
			"alaviss/tree-sitter-nim",
		},
		config = function()
			vim.treesitter.language("nim", "tree-sitter-nim")
		end,
		lazy = true,
	},
	{
		"catppuccin/nvim",
		name = "catppuccin",
		priority = 1000,
		config = function()
			require("kradlus.core.catppuccin")
		end,
	},

	-- Harpoon 2
	{
		"ThePrimeagen/harpoon",
		lazy = false,
		dependencies = { "nvim-lua/plenary.nvim" },
		branch = "harpoon2",
		config = function()
			require("kradlus.plugins.harpoon")
		end,
	},

	{
		"danymat/neogen",
		dependencies = "nvim-treesitter/nvim-treesitter",
		config = true,
		-- Uncomment next line if you want to follow only stable versions
		-- version = "*"
	},
})
