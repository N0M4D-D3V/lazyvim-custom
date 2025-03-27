-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

-- format docs with (CTRL+SHIFT+F)
-- vim.api.nvim_set_keymap('n', '<C-S-f>', ':Format<CR>', { noremap = true, silent = true })

-- open or focus integrated Term (CTRL+SHIFT+T)
-- vim.api.nvim_set_keymap('n', '<C-S-t>', ':ToggleTerm<CR>', { noremap = true, silent = true })

-- focus active editor (CTRL+SHIFT+E)
-- vim.api.nvim_set_keymap('n', '<C-S-e>', '<C-w>p', { noremap = true, silent = true })

-- Enfocar la ventana a la dcha/izqda (Ctrl+Shift+Right)(Ctrl+Shift+Left)
vim.api.nvim_set_keymap('n', '<C-S-Right>', '<C-w>l', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<C-S-Left>', '<C-w>h', { noremap = true, silent = true })

-- Save file
vim.api.nvim_set_keymap('n', '<C-S-s>', ':w<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('i', '<C-S-s>', '<Esc>:w<CR>a', { noremap = true, silent = true })

-- Ir al inicio/fin de la línea en modo inserción
vim.api.nvim_set_keymap('i', '<C-S-Left>', '<C-o>^', { noremap = true, silent = true })
vim.api.nvim_set_keymap('i', '<C-S-Right>', '<C-o>$', { noremap = true, silent = true })
vim.api.nvim_set_keymap('v', '<C-S-Left>', '^', { noremap = true, silent = true })
vim.api.nvim_set_keymap('v', '<C-S-Right>', 'g_', { noremap = true, silent = true })

-- (ALT+Arrow) Mover línea actual hacia arriba/abajo en modo inserción
vim.api.nvim_set_keymap('i', '<C-S-Up>', '<Esc>:m .-2<CR>==gi', { noremap = true, silent = true })
vim.api.nvim_set_keymap('i', '<C-S-Down>', '<Esc>:m .+1<CR>==gi', { noremap = true, silent = true })

-- Mover bloque seleccionado hacia arriba/abajo
vim.api.nvim_set_keymap('v', '<C-S-Up>', ":m '<-2<CR>gv=gv", { noremap = true, silent = true })
vim.api.nvim_set_keymap('v', '<C-S-Down>', ":m '>+1<CR>gv=gv", { noremap = true, silent = true })