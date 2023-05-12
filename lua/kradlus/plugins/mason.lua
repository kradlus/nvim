local mason_ok, mason = pcall(require, 'mason')
if not mason_ok then
  print("Failed to load Mason")
  return
end

mason.setup()

