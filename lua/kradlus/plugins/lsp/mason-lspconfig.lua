local mason_ok, mason = pcall(require, "mason-lspconfig")
if not mason_ok then
	print("Failed to load mason-lspconfig")
	return
end

local lspconfig_ok, lspconfig = pcall(require, "lspconfig")
if not lspconfig_ok then
	return
end

mason.setup({
	ensure_installed = { "lua_ls", "rust_analyzer", "zls", "pyright", "pylsp" },
	automatic_installation = true,
})

return mason.setup_handlers({
	-- The first entry (without a key) will be the default handler
	-- and will be called for each installed server that doesn't have
	-- a dedicated handler.
	function(server_name) -- default handler (optional)
		lspconfig[server_name].setup({})
	end,
	["lua_ls"] = function()
		lspconfig.lua_ls.setup({
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
