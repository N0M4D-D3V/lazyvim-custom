local lspconfig = require("lspconfig")

-- Angular Language Server (ngserver)
lspconfig.angularls.setup({
  root_dir = lspconfig.util.root_pattern("angular.json"),
})
