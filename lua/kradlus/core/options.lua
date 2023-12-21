-- Leader
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Set Tab
vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
vim.opt.softtabstop = 2

-- vim.cmd([[ :set colorcolumn=80 ]])
vim.cmd([[ :set expandtab ]])
vim.cmd([[ :set nowrap ]])

-- Numbers
vim.opt.number = true
vim.opt.relativenumber = true

-- Background
vim.o.background = "dark"

-- Theme
vim.opt.termguicolors = true
pcall(vim.cmd, "colorscheme catppuccin")
