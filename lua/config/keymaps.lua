-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

-- ████████████████████████████████
--
-- ██   ██ ███████ ██    ██ ███████
-- ██  ██  ██       ██  ██  ██
-- █████   █████     ████   ███████
-- ██  ██  ██         ██         ██
-- ██   ██ ███████    ██    ███████
--
-- ████████████████████████████████

-- backstick
vim.keymap.set("i", "<C-q>", "`", { desc = "Insert backtick" })

-- ███████████████████████████████████████████
--
-- ███████ ███    ███  █████  ██████  ████████
-- ██      ████  ████ ██   ██ ██   ██    ██
-- ███████ ██ ████ ██ ███████ ██████     ██
--      ██ ██  ██  ██ ██   ██ ██   ██    ██
-- ███████ ██      ██ ██   ██ ██   ██    ██
--
-- ███████████████████████████████████████████

-- add new line bottom/top
vim.keymap.set("n", "<CR>", "o<Esc>", { desc = "Add new line after" })
vim.keymap.set("n", "<S-CR>", "O<Esc>", { desc = "Add new line before" })

-- Save file
vim.keymap.set({ "n", "i", "v" }, "<C-s>", "<Esc>:w<CR>", { desc = "Save file" })

-- Reload config
vim.keymap.set("n", "<Leader>rr", ":source $MYVIMRC<CR>", { desc = "Reload config" })

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

-- █████████████████████████████████████████████████████████████████████████████
--
-- ███    ██  █████  ██    ██ ██  ██████   █████  ████████ ██  ██████  ███    ██
-- ████   ██ ██   ██ ██    ██ ██ ██       ██   ██    ██    ██ ██  ████ ████   ██
-- ██ ██  ██ ███████ ██    ██ ██ ██   ███ ███████    ██    ██ ██ ██ ██ ██ ██  ██
-- ██  ██ ██ ██   ██  ██  ██  ██ ██    ██ ██   ██    ██    ██ ████  ██ ██  ██ ██
-- ██   ████ ██   ██   ████   ██  ██████  ██   ██    ██    ██  ██████  ██   ████
--
-- ██████████████████████████████████████████████████████████████████████████████

-- Focus on Left/Right tab
vim.api.nvim_set_keymap("n", "<C-S-Right>", "<C-w>l", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<C-S-Left>", "<C-w>h", { noremap = true, silent = true })

-- GoTo next/prev buffer
vim.keymap.set("n", "<Tab>", ":bnext<CR>", { desc = "Next buffer" })
vim.keymap.set("n", "<S-Tab>", ":bprevious<CR>", { desc = "Previous buffer" })

-- open vertical split of current file
vim.keymap.set("n", "<C-n>", function()
  --si hay un vertical split, lo usa, si no, lo creamos
  vim.cmd("vsplit")
  -- carga el mismo buffer en el nuevo split
  vim.cmd("buffer #")
end, { desc = "Vertical Split with current buffer" })

-- ████████████████████████████████████████████████████████████████████
--
--  ██████ ██      ██ ██████  ██████   ██████   █████  ██████  ██████
--  ██      ██      ██ ██   ██ ██   ██ ██    ██ ██   ██ ██   ██ ██   ██
--  ██      ██      ██ ██████  ██████  ██    ██ ███████ ██████  ██   ██
--  ██      ██      ██ ██      ██   ██ ██    ██ ██   ██ ██   ██ ██   ██
--   ██████ ███████ ██ ██      ██████   ██████  ██   ██ ██   ██ ██████
--  __________________________________________________________________
-- | For UNDO/REDO Work add stty susp undef to your                   |
-- | .bashrc/.zshrc/.bash_profile                                     |
-- ████████████████████████████████████████████████████████████████████

-- PASTE
vim.keymap.set("i", "<C-v>", "<C-r>+", { noremap = true, silent = true })
vim.keymap.set("n", "<C-v>", '"+p', { noremap = true, silent = true }) -- normal mode
vim.keymap.set("v", "<C-v>", '"+p', { noremap = true, silent = true })

-- SMART COPY
vim.keymap.set({ "n", "v" }, "<C-c>", function()
  local mode = vim.fn.mode()
  if mode:match("[vV]") then
    vim.cmd('normal! "+y') -- copy selection
  else
    vim.cmd('normal! "+yy') -- copy full line
  end
end, { desc = "Smart Copy to Clipboard (Ctrl+C)", noremap = true, silent = true })

-- SMART CUT
vim.keymap.set({ "n", "v" }, "<C-x>", function()
  local mode = vim.fn.mode()
  if mode:match("[vV]") then
    -- if visual mode, cut selection
    vim.cmd('normal! "+x')
  else
    -- if normal mode, cut full line
    vim.cmd('normal! "+dd')
  end
end, { desc = "Smart Cut", noremap = true, silent = true })

-- UNDO
vim.keymap.set({ "n", "i" }, "<C-z>", "u", { desc = "Undo" })

-- REDO
vim.keymap.set({ "n", "i" }, "<C-y>", "<C-r>", { desc = "Redo" })

-- SELECT ALL
local opts = { noremap = true, silent = true }

vim.keymap.set({ "n", "v" }, "<C-a>", "ggVG", opts)
vim.keymap.set("i", "<C-a>", "<Esc>ggVG", opts)

-- ███████████████████████████████████████████████████████████████████████████████████████████████
--
-- ████████ ███████ ██   ██ ████████     ██   ██  █████  ███    ██ ██████  ██      ███████ ██████
--    ██    ██       ██ ██     ██        ██   ██ ██   ██ ████   ██ ██   ██ ██      ██      ██   ██
--    ██    █████     ███      ██        ███████ ███████ ██ ██  ██ ██   ██ ██      █████   ██████
--    ██    ██       ██ ██     ██        ██   ██ ██   ██ ██  ██ ██ ██   ██ ██      ██      ██   ██
--    ██    ███████ ██   ██    ██        ██   ██ ██   ██ ██   ████ ██████  ███████ ███████ ██   ██
--
-- ███████████████████████████████████████████████████████████████████████████████████████████████

-- Go to start/end of line
vim.api.nvim_set_keymap("i", "<C-S-Left>", "<C-o>^", { noremap = true, silent = true })
vim.api.nvim_set_keymap("i", "<C-S-Right>", "<C-o>$", { noremap = true, silent = true })
vim.api.nvim_set_keymap("v", "<C-S-Left>", "^", { noremap = true, silent = true })
vim.api.nvim_set_keymap("v", "<C-S-Right>", "g_", { noremap = true, silent = true })

-- Move Up/Down
vim.api.nvim_set_keymap("i", "<C-S-Up>", "<Esc>:m .-2<CR>==gi", { noremap = true, silent = true })
vim.api.nvim_set_keymap("i", "<C-S-Down>", "<Esc>:m .+1<CR>==gi", { noremap = true, silent = true })

vim.keymap.set("v", "<C-S-Up>", ":m '<-2<CR>gv=gv", { desc = "Move selection up", silent = true })
vim.keymap.set("v", "<C-S-Down>", ":m '>+1<CR>gv=gv", { desc = "Move selection down", silent = true })

-- Mantener selección después de indentar
vim.keymap.set("v", "<", "<gv", { desc = "Left indent and keep selection" })
vim.keymap.set("v", ">", ">gv", { desc = "Right indent and keep selection" })
