local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"https://github.com/folke/lazy.nvim.git",
		"--branch=stable", -- latest stable release
		lazypath,
	})
end
vim.opt.rtp:prepend(lazypath)

local lazy_ok, lazy = pcall(require, "lazy")
if not lazy_ok then
	return
end

lazy.setup({

	{
		"folke/which-key.nvim",
		{ "folke/neoconf.nvim", cmd = "Neoconf" },
		"folke/neodev.nvim",
	},

	-- Post-install/update hook with neovim command
	{ "nvim-treesitter/nvim-treesitter" },

	{
		"nvim-treesitter/nvim-treesitter-context",
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
		tag = "0.1.1",
		lazy = true,
		dependencies = {
			{ "nvim-lua/plenary.nvim" },
			{ "nvim-telescope/telescope-symbols.nvim" },
		},
	},

	-- LSP
	{
		"VonHeikemen/lsp-zero.nvim",
		branch = "v2.x",
		dependencies = {
			-- LSP Support
			{ "neovim/nvim-lspconfig" }, -- Required

			{
				-- Optional
				"williamboman/mason.nvim",
				lazy = true,
				build = function()
					pcall(vim.cmd, "MasonUpdate")
				end,
			},

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
	{ "lukas-reineke/indent-blankline.nvim" },

	-- nvim-linefly
	{ "bluz71/nvim-linefly" },

	-- LazyGit
	{
		"kdheepak/lazygit.nvim",
		-- optional for floating window border decoration
		dependencies = {
			"nvim-lua/plenary.nvim",
		},
	},

	-- Markdown preview
	{
		"iamcco/markdown-preview.nvim",
		build = "cd app && yarn install",
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
			require("catppuccin").setup({
				transparent_background = true,
			})
		end,
	},
})
