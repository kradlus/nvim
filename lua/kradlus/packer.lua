-- Only required if you have packer configured as `opt`
-- vim.cmd [[packadd packer.nvim]]

-- This file can be loaded by calling `lua require('plugins')` from your init.vim
local ensure_packer = function()
	local fn = vim.fn
	local install_path = fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"
	if fn.empty(fn.glob(install_path)) > 0 then
		fn.system({ "git", "clone", "--depth", "1", "https://github.com/wbthomason/packer.nvim", install_path })
		vim.cmd([[packadd packer.nvim]])
		return true
	end
	return false
end

-- Vim Autocmd
vim.cmd([[
  augroup packer_user_config
      autocmd!
      autocmd BufWritePost packer.lua source <afile> | PackerSync
  augroup end
]])

local packer_bootstrap = ensure_packer()

local packer_ok, packer = pcall(require, "packer")
if not packer_ok then
	return
end

return packer.startup({
	function(use)
		-- Packer can manage itself
		use("wbthomason/packer.nvim")

		-- Post-install/update hook with neovim command
		use({ "nvim-treesitter/nvim-treesitter" })
		use({
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
		})

		-- Use dependency and run lua function after load
		use({
			"lewis6991/gitsigns.nvim",
			requires = { "nvim-lua/plenary.nvim" },
			config = function()
				local gitsigns_ok, gitsigns = pcall(require, "gitsigns")
				if not gitsigns_ok then
					return
				end

				-- gitsigns setup
				gitsigns.setup()
			end,
		})

		-- Telescope
		use({
			"nvim-telescope/telescope.nvim",
			tag = "0.1.1",
			requires = {
				{ "nvim-lua/plenary.nvim" },
				{ "nvim-telescope/telescope-symbols.nvim" },
			},
		})

		-- LSP
		use({
			"VonHeikemen/lsp-zero.nvim",
			branch = "v2.x",
			requires = {
				-- LSP Support
				{ "neovim/nvim-lspconfig" }, -- Required

				{
					-- Optional
					"williamboman/mason.nvim",
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
					requires = { "nvim-lua/plenary.nvim" },
				},

				-- Autopair
				use({
					"windwp/nvim-autopairs",
					config = function()
						local ok, autopair = pcall(require, "nvim-autopairs")
						if not ok then
							return
						end

						autopair.setup()
					end,
				}),
			},
		})

		-- Comment
		use({
			"numToStr/Comment.nvim",
			config = function()
				require("Comment").setup()
			end,
		})

		-- rose-pine
		use({ "rose-pine/neovim" })

		if packer_bootstrap then
			packer.sync()
		end
	end,

	config = {
		display = {
			open_fn = require("packer.util").float,
		},
	},
})
