local lspconfig = require("lspconfig")

lspconfig.tsserver.setup({
  root_dir = lspconfig.util.root_pattern("tsconfig.json", "package.json"),
})

-- format with prettier
vim.api.nvim_create_autocmd("BufWritePre", {
  pattern = { "*.ts", "*.tsx", "*.js", "*.jsx" },
  callback = function()
    vim.cmd("silent! EslintFixAll") -- Require eslint + plugin
  end,
})
