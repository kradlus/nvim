local ibl_ok, ibl = pcall(require, "ibl")
if not ibl_ok then
	print("Cannot load ibl")
end

ibl.setup({})
