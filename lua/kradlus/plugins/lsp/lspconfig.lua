local lsp_ok, lsp = pcall(require, 'lsp-zero')
if not lsp_ok then
  return
end

lsp.preset({})
lsp.on_attach(function(_, bufnr)
  lsp.default_keymaps({ buffer = bufnr })
end)

lsp.setup()
