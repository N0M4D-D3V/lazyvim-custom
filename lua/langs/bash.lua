-- instal by using mason install bash-language-server
local lspconfig = require("lspconfig")

lspconfig.bashls.setup({
  filetypes = { "sh", "bash" },
  root_dir = lspconfig.util.find_git_ancestor,
})

vim.api.nvim_create_autocmd("FileType", {
  pattern = "sh",
  callback = function()
    vim.bo.tabstop = 4,
    vim.bo.shiftwidth = 4,
    vim.bo.expandtab = true
  end,
})
