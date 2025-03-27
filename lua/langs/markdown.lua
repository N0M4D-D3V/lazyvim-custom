-- marksman installation required: brew install marksman (or mason)

vim.api.nvim_create_autocmd("FileType", {
  pattern = "markdown",
  callback = function()
    vim.wo.spell = true
    vim.bo.warp = true
    vim.bo.shiftwidth = 2
  end,
})

-- LSP optional: markdownlint or remark-lsp
local lspconfig = require("lspconfig")

lspconfig.marksman.setup({
  filetypes = { "markdown" },
  root_dir = lspconfig.util.root_pattern(".git", "."),
})
