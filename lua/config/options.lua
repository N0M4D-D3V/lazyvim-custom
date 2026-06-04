-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here

-- Enable clipboard support
vim.opt.clipboard = 'unnamedplus'

local has = vim.fn.has
local executable = vim.fn.executable

if has('macunix') == 1 and executable('pbcopy') == 1 and executable('pbpaste') == 1 then
  vim.g.clipboard = {
    name = 'macOS-clipboard',
    copy = {
      ['+'] = 'pbcopy',
      ['*'] = 'pbcopy',
    },
    paste = {
      ['+'] = 'pbpaste',
      ['*'] = 'pbpaste',
    },
    cache_enabled = 0,
  }
elseif vim.env.WAYLAND_DISPLAY and executable('wl-copy') == 1 and executable('wl-paste') == 1 then
  vim.g.clipboard = {
    name = 'wayland-clipboard',
    copy = {
      ['+'] = 'wl-copy --foreground --type text/plain',
      ['*'] = 'wl-copy --foreground --primary --type text/plain',
    },
    paste = {
      ['+'] = 'wl-paste --no-newline',
      ['*'] = 'wl-paste --no-newline --primary',
    },
    cache_enabled = 0,
  }
elseif vim.env.DISPLAY and executable('xclip') == 1 then
  vim.g.clipboard = {
    name = 'xclip-clipboard',
    copy = {
      ['+'] = 'xclip -selection clipboard',
      ['*'] = 'xclip -selection primary',
    },
    paste = {
      ['+'] = 'xclip -selection clipboard -o',
      ['*'] = 'xclip -selection primary -o',
    },
    cache_enabled = 0,
  }
end
