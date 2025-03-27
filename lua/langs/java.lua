-- jdtls instalation required (you can install it by mason.nvim or manually)

local lspconfig = require("lspconfig")

lspconfig.jdtls.setup({
  cmd = { "jdtls" },
  root_dir = lspconfig.util.root_pattern(".git", "mvnw", "gradlew", "build.gradle"),
})
