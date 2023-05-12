-- Leader
vim.g.mapleader = " "
vim.g.globalleader = " "

-- Set Tab
vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
vim.cmd [[ :set expandtab ]]

-- Numbers
vim.opt.number = true
vim.opt.relativenumber = true

-- Theme
pcall(vim.cmd, "colorscheme tokyonight")
