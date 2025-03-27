local lspconfig = require("lspconfig")

lspconfig.pyright.setup({
  root_dir = lspconfig.util.root_pattern("pyproject.toml", "setup.py", ".git"),
})

-- format with black when save (black instalation required)
vim.api.nvim_create_autocmd("BufWritePre", {
  pattern = "*.py",
  callback = function()
    vim.cmd("silent! !black %")
  end,
})
