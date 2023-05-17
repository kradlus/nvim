-- Leader
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Set Tab
vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
vim.cmd([[ :set expandtab ]])

-- Numbers
vim.opt.number = true
vim.opt.relativenumber = true

-- Theme
vim.opt.termguicolors = true
pcall(vim.cmd, "colorscheme rose-pine")
