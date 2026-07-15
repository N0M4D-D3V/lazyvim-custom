-- Options are automatically loaded before lazy.nvim startup.

local has = vim.fn.has
local executable = vim.fn.executable

if has("macunix") == 1
  and executable("pbcopy") == 1
  and executable("pbpaste") == 1
then
  vim.g.clipboard = {
    name = "macOS clipboard",
    copy = {
      ["+"] = { "pbcopy" },
      ["*"] = { "pbcopy" },
    },
    paste = {
      ["+"] = { "pbpaste" },
      ["*"] = { "pbpaste" },
    },
    cache_enabled = 0,
  }
else
  -- Kitty and other compatible terminals.
  vim.g.clipboard = "osc52"
end

vim.opt.clipboard = "unnamedplus"