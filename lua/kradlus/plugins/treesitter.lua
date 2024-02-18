local ok, treesitter = pcall(require, "nvim-treesitter.configs")
if not ok then
	return
end

---@diagnostic disable-next-line: redefined-local
local ok, parsers = pcall(require, "nvim-treesitter.parsers")
if not ok then
	print("Unable to load TreeSitter parsers")
	return
end

parsers.get_parser_configs().asm = {
	install_info = {
		url = "https://github.com/rush-rs/tree-sitter-asm.git",
		files = { "src/parser.c" },
		branch = "main",
	},
	filetype = { "asm", "fasm", "nasm" },
}

vim.cmd("autocmd BufRead,BufNewFile *.asm set ft=asm")
vim.cmd("autocmd BufRead,BufNewFile *.fasm set ft=fasm")
vim.cmd("autocmd BufRead,BufNewFile *.nasm set ft=nasm")

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
