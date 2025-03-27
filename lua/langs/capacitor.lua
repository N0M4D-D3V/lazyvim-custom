vim.api.nvim_create_autocmd("BufRead,BufNewFile", {
  pattern = "capacitor.config.ts",
  callback = function()
    vim.bo.filetype = "typescript"
    vim.cmd("echo 'Capacitor config detected'")
  end,
})
