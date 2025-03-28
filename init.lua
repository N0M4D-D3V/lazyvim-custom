-- bootstrap lazy.nvim, LazyVim and your plugins
require("config.lazy")
require("config.keymaps")

vim.opt.encoding = "utf-8"
vim.opt.fileencoding = "utf-8"
vim.g.lazyvim_check_order = false
-- Enable local config files
vim.o.exrc = true

-- Prevent unsafe commands in local configs
vim.o.secure = true

vim.cmd([[colorscheme tokyonight-day]])

-- load .nvim.lua if exists in the project
local local_config = vim.fn.getcwd() .. "/.nvim.lua"
if vim.fn.filereadable(local_config) == 1 then
  dofile(local_config)
end
