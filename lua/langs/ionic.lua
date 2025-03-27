vim.api.create_autocmd("FileType", {
  pattern = { "typescript", "html", "scss" },
  callback = function()
    vim.bo.shiftwidth = 2
    vim.bo.tabstop = 2
    vim.bo.expandtab = true
    vim.bo.autoindent = true
  end,
})
