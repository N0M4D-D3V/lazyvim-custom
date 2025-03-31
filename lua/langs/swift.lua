local lspconfig = require("lspconfig")

lspconfig.swift.setup({
  filetypes = { "swift" },
  cmd = { "xcrun", "sourcekit-lsp" },
  root_dir = require("lspconfig.util").root_pattern("Package.swift", ".git"),
})
