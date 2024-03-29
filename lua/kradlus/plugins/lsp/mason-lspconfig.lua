local mason_ok, mason = pcall(require, "mason-lspconfig")
if not mason_ok then
	print("Failed to load mason-lspconfig")
	return
end

local lspconfig_ok, lspconfig = pcall(require, "lspconfig")
if not lspconfig_ok then
	return
end

local nvim_cmp_ok, nvim_cmp = pcall(require, "cmp_nvim_lsp")
if not nvim_cmp_ok then
	return
end

mason.setup({
	ensure_installed = { "lua_ls", "rust_analyzer", "zls", "pyright", "pylsp", "gopls" },
	automatic_installation = true,
})

local capabilities = nvim_cmp.default_capabilities()

mason.setup_handlers({
	-- The first entry (without a key) will be the default handler
	-- and will be called for each installed server that doesn't have
	-- a dedicated handler.
	function(server_name) -- default handler (optional)
		lspconfig[server_name].setup({
			capabilities = capabilities,
			opts = {
				inlay_hints = { enable = true },
			},
		})
	end,
	["lua_ls"] = function()
		lspconfig.lua_ls.setup({
			capabilities = capabilities,
			settings = {
				Lua = {
					diagnostics = {
						globals = { "vim" },
					},
				},
			},
		})
	end,
})
