local lspconfig = require("lspconfig")

lspconfig.astro.setup({
  root_dir = lspconfig.util.root_pattern("astro.config.mjs", "package.json"),
})

vim.api.nvim_create_autocmd("FileType", {
  pattern = "astro",
  callback = function()
    vim.bo.shiftwidth = 2
    vim.bo.tabstop = 2
  end,
})
