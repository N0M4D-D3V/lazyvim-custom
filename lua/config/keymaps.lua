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

-- Window navigation
vim.keymap.set("n", "<C-h>", "<C-w>h", { desc = "Go to left window" })
vim.keymap.set("n", "<C-j>", "<C-w>j", { desc = "Go to lower window" })
vim.keymap.set("n", "<C-k>", "<C-w>k", { desc = "Go to upper window" })
vim.keymap.set("n", "<C-l>", "<C-w>l", { desc = "Go to right window" })

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

local function copy_current_line_to_clipboard()
  vim.cmd('normal! "+yy')
end

local function copy_selection_to_clipboard()
  vim.cmd('normal! "+y')
end

local function copy_current_line_from_insert()
  local pos = vim.api.nvim_win_get_cursor(0)
  vim.cmd("stopinsert")
  copy_current_line_to_clipboard()
  vim.api.nvim_win_set_cursor(0, pos)
  vim.cmd("startinsert")
end

local function paste_into_terminal()
  local job_id = vim.b.terminal_job_id
  if not job_id then
    vim.notify("No terminal job attached to this buffer", vim.log.levels.WARN)
    return
  end

  vim.api.nvim_chan_send(job_id, vim.fn.getreg("+"))
end

-- PASTE
vim.keymap.set("i", "<C-v>", "<C-r>+", { noremap = true, silent = true })
vim.keymap.set("c", "<C-v>", "<C-r>+", { noremap = true, silent = true })
vim.keymap.set("n", "<C-v>", '"+p', { noremap = true, silent = true }) -- normal mode
vim.keymap.set("v", "<C-v>", '"+p', { noremap = true, silent = true })
vim.keymap.set("t", "<C-v>", paste_into_terminal, { noremap = true, silent = true, desc = "Paste clipboard into terminal" })

-- SMART COPY
vim.keymap.set("n", "<C-c>", copy_current_line_to_clipboard, { desc = "Copy line to clipboard", noremap = true, silent = true })
vim.keymap.set({ "v", "x", "s" }, "<C-c>", copy_selection_to_clipboard, { desc = "Copy selection to clipboard", noremap = true, silent = true })
vim.keymap.set("i", "<C-c>", copy_current_line_from_insert, { desc = "Copy line to clipboard", noremap = true, silent = true })

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
