local telescope_ok, telescope = pcall(require, "telescope")
if not telescope_ok then
	print("Cannot load telescope")
	return
end

local builtin = require("telescope.builtin")
vim.keymap.set("n", "<leader>ff", builtin.find_files, {})
vim.keymap.set("n", "<leader>fw", builtin.live_grep, {})
vim.keymap.set("n", "<leader>fb", builtin.buffers, {})
vim.keymap.set("n", "<leader>fh", builtin.help_tags, {})
vim.keymap.set("n", "<leader>fk", builtin.keymaps, {})
vim.keymap.set("n", "<leader>fs", builtin.lsp_document_symbols, {})
vim.keymap.set("n", "<leader>fd", builtin.diagnostics, {})

return telescope.setup({
	defaults = {
		layout_strategy = "vertical",
		layout_config = {
			prompt_position = "top",
			mirror = true,
		},
	},
})
