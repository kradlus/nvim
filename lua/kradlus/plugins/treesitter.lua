local ok, treesitter = pcall(require, "nvim-treesitter.configs")
if not ok then
	return
end

treesitter.setup({
	ensure_installed = { "c", "python", "go", "javascript", "typescript", "lua" },
	sync_install = false,
	auto_install = true,
	indent = { enable = true },
	highlight = {
		enable = true,
		additional_vim_regex_highlighting = false,
	},
})
