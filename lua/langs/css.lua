local lspconfig = require("lspconfig")

lspconfig.cssls.setup({
  filetypes = { "css", "scss" },
  settings = {
    css = { validate = true },
    scss = { validate = true },
  },
})
