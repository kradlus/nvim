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
			},
		})

		-- Lualine
		use({
			"nvim-lualine/lualine.nvim",
			requires = { "nvim-tree/nvim-web-devicons", opt = true },
			config = function()
				local lualine_ok, lualine = pcall(require, "lualine")
				if not lualine_ok then
					return
				end

				lualine.setup({
					options = {
						theme = "material",
					},
				})
			end,
		})

		-- TokyoNight
		use({ "folke/tokyonight.nvim" })

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
