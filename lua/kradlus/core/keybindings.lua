-- opts
local opts = { noremap = true, silent = true }

-- Nohlsearch
vim.keymap.set({ "n", "v" }, "<C-h>", ":nohlsearch<CR>", opts)

-- Move Higlighted text
vim.keymap.set({ "n", "v" }, "<A-j>", ":m '>+1<CR>gv=gv", opts)
vim.keymap.set({ "n", "v" }, "<A-k>", ":m '<-2<CR>gv=gv", opts)

-- Open Ex
vim.keymap.set({ "n", "v" }, "<leader>pv", ":Ex<CR>", opts)

-- Indentation
vim.keymap.set({ "n", "v" }, ">", ">gv", opts)
vim.keymap.set({ "n", "v" }, "<", "<gv", opts)
