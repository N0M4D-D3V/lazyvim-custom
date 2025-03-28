-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

-- format docs with (CTRL+SHIFT+F)
-- vim.api.nvim_set_keymap('n', '<C-S-f>', ':Format<CR>', { noremap = true, silent = true })

-- open or focus integrated Term (CTRL+SHIFT+T)
vim.keymap.set("n", "<leader>t", function()
  local terminals = {}
  for _, win in ipairs(vim.api.nvim_list_wins()) do
    local buf = vim.api.nvim_win_get_buf(win)
    if vim.bo[buf].buftype == "terminal" then
      table.insert(terminals, win)
    end
  end

  if #terminals > 0 then
    -- Ya hay al menos un terminal: hacemos foco al primero que encontramos
    vim.api.nvim_set_current_win(terminals[1])
  else
    -- No hay terminal: lo creamos en un split inferior
    vim.cmd("belowright split | terminal")
    vim.cmd("resize 15")
  end

  vim.cmd("startinsert")
end, { noremap = true, silent = true, desc = "Open/focus integrated terminal" })

-- focus active editor (CTRL+SHIFT+E)
-- vim.api.nvim_set_keymap('n', '<C-S-e>', '<C-w>p', { noremap = true, silent = true })

-- Ctrl + v para pegar en
vim.keymap.set({ "n", "v" }, "<C-v>", '"+p', { noremap = true, silent = true })
vim.keymap.set("i", "<C-v>", "<C-r>+", { noremap = true, silent = true })

-- Enfocar la ventana a la dcha/izqda (Ctrl+Shift+Right)(Ctrl+Shift+Left)
vim.api.nvim_set_keymap("n", "<C-S-Right>", "<C-w>l", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<C-S-Left>", "<C-w>h", { noremap = true, silent = true })

-- Save file
vim.api.nvim_set_keymap("n", "<C-S-s>", ":w<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("i", "<C-S-s>", "<Esc>:w<CR>a", { noremap = true, silent = true })

-- Ir al inicio/fin de la línea
vim.api.nvim_set_keymap("i", "<C-S-Left>", "<C-o>^", { noremap = true, silent = true })
vim.api.nvim_set_keymap("i", "<C-S-Right>", "<C-o>$", { noremap = true, silent = true })
vim.api.nvim_set_keymap("v", "<C-S-Left>", "^", { noremap = true, silent = true })
vim.api.nvim_set_keymap("v", "<C-S-Right>", "g_", { noremap = true, silent = true })

-- Mover hacia arriba/abajo
vim.api.nvim_set_keymap("i", "<C-S-Up>", "<Esc>:m .-2<CR>==gi", { noremap = true, silent = true })
vim.api.nvim_set_keymap("i", "<C-S-Down>", "<Esc>:m .+1<CR>==gi", { noremap = true, silent = true })

vim.api.nvim_set_keymap("v", "<C-S-Up>", ":m '<-2<CR>gv=gv", { noremap = true, silent = true })
vim.api.nvim_set_keymap("v", "<C-S-Down>", ":m '>+1<CR>gv=gv", { noremap = true, silent = true })
