-- Keymaps are automatically loaded on the VeryLazy event.
-- LazyVim normally loads:
-- ~/.config/nvim/lua/config/keymaps.lua
--
-- If this file is named keybindings.lua, import it from keymaps.lua:
-- require("config.keybindings")

local map = vim.keymap.set

-- ============================================================================
-- KEYS
-- ============================================================================

-- Insert backtick
map("i", "<C-q>", "`", {
  desc = "Insert backtick",
})

-- ============================================================================
-- EDITING
-- ============================================================================

-- Add empty line without entering insert mode
map("n", "<CR>", "o<Esc>", {
  desc = "Add new line after",
  silent = true,
})

map("n", "<S-CR>", "O<Esc>", {
  desc = "Add new line before",
  silent = true,
})

-- Save file
map({ "n", "v" }, "<C-s>", "<Cmd>write<CR>", {
  desc = "Save file",
  silent = true,
})

map("i", "<C-s>", "<Esc><Cmd>write<CR>a", {
  desc = "Save file",
  silent = true,
})

-- Reload Neovim configuration
map("n", "<Leader>rr", function()
  vim.cmd("source $MYVIMRC")
  vim.notify("Neovim configuration reloaded", vim.log.levels.INFO)
end, {
  desc = "Reload config",
  silent = true,
})

-- ============================================================================
-- INTEGRATED TERMINAL
-- ============================================================================

local function open_or_focus_terminal()
  for _, win in ipairs(vim.api.nvim_list_wins()) do
    local buffer = vim.api.nvim_win_get_buf(win)

    if vim.bo[buffer].buftype == "terminal" then
      vim.api.nvim_set_current_win(win)
      vim.cmd.startinsert()
      return
    end
  end

  vim.cmd("belowright split")
  vim.cmd("terminal")
  vim.cmd("resize 15")
  vim.cmd.startinsert()
end

map("n", "<Leader>t", open_or_focus_terminal, {
  desc = "Open/focus integrated terminal",
  silent = true,
})

-- ============================================================================
-- WINDOW NAVIGATION
-- ============================================================================

map("n", "<C-h>", "<C-w>h", {
  desc = "Go to left window",
  silent = true,
})

map("n", "<C-j>", "<C-w>j", {
  desc = "Go to lower window",
  silent = true,
})

map("n", "<C-k>", "<C-w>k", {
  desc = "Go to upper window",
  silent = true,
})

map("n", "<C-l>", "<C-w>l", {
  desc = "Go to right window",
  silent = true,
})

map("n", "<C-S-Left>", "<C-w>h", {
  desc = "Go to left window",
  silent = true,
})

map("n", "<C-S-Right>", "<C-w>l", {
  desc = "Go to right window",
  silent = true,
})

-- ============================================================================
-- BUFFER NAVIGATION
-- ============================================================================

map("n", "<Tab>", "<Cmd>bnext<CR>", {
  desc = "Next buffer",
  silent = true,
})

map("n", "<S-Tab>", "<Cmd>bprevious<CR>", {
  desc = "Previous buffer",
  silent = true,
})

-- Open current buffer in a vertical split
map("n", "<C-n>", function()
  vim.cmd("vsplit")
end, {
  desc = "Vertical split with current buffer",
  silent = true,
})

-- ============================================================================
-- CLIPBOARD
--
-- Requires:
--   vim.g.clipboard = "osc52"
--   vim.opt.clipboard = "unnamedplus"
--
-- With unnamedplus enabled, normal y/d/p operations already use the "+"
-- clipboard. Explicit "+ operations are deliberately avoided here.
-- ============================================================================

-- Copy current line
map("n", "<C-c>", "yy", {
  desc = "Copy line",
  silent = true,
})

-- Copy visual selection
--
-- `y` exits visual mode after copying, matching normal editor behaviour.
map("x", "<C-c>", "y", {
  desc = "Copy selection",
  silent = true,
})

-- Select-mode copy
map("s", "<C-c>", "<C-g>y", {
  desc = "Copy selection",
  silent = true,
})

-- Copy current line while staying in insert mode
map("i", "<C-c>", function()
  local cursor = vim.api.nvim_win_get_cursor(0)

  vim.cmd("stopinsert")
  vim.cmd("normal! yy")

  local line_count = vim.api.nvim_buf_line_count(0)
  cursor[1] = math.min(cursor[1], line_count)

  local line = vim.api.nvim_buf_get_lines(
    0,
    cursor[1] - 1,
    cursor[1],
    false
  )[1] or ""

  cursor[2] = math.min(cursor[2], #line)

  vim.api.nvim_win_set_cursor(0, cursor)
  vim.cmd("startinsert")
end, {
  desc = "Copy current line",
  silent = true,
})

-- Paste after cursor
map("n", "<C-v>", "p", {
  desc = "Paste",
  silent = true,
})

-- Replace visual selection without overwriting the clipboard
map("x", "<C-v>", '"_dP', {
  desc = "Paste over selection",
  silent = true,
})

map("s", "<C-v>", '<C-g>"_dP', {
  desc = "Paste over selection",
  silent = true,
})

-- Paste in insert mode
map("i", "<C-v>", "<C-r>+", {
  desc = "Paste clipboard",
  silent = true,
})

-- Paste in command-line mode
map("c", "<C-v>", "<C-r>+", {
  desc = "Paste clipboard",
})

-- Paste into an integrated terminal
local function paste_into_terminal()
  local job_id = vim.b.terminal_job_id

  if not job_id then
    vim.notify(
      "No terminal job attached to this buffer",
      vim.log.levels.WARN
    )
    return
  end

  local ok, clipboard = pcall(vim.fn.getreg, "+")

  if not ok then
    vim.notify(
      "Could not read the system clipboard",
      vim.log.levels.ERROR
    )
    return
  end

  if clipboard == "" then
    return
  end

  vim.api.nvim_chan_send(job_id, clipboard)
end

map("t", "<C-v>", paste_into_terminal, {
  desc = "Paste clipboard into terminal",
  silent = true,
})

-- ============================================================================
-- SMART CUT
-- ============================================================================

-- Cut current line in normal mode
map("n", "<C-x>", "dd", {
  desc = "Cut line",
  silent = true,
})

-- Cut selected text in visual mode
map("x", "<C-x>", "d", {
  desc = "Cut selection",
  silent = true,
})

map("s", "<C-x>", "<C-g>d", {
  desc = "Cut selection",
  silent = true,
})

-- ============================================================================
-- UNDO / REDO
-- ============================================================================

map("n", "<C-z>", "u", {
  desc = "Undo",
  silent = true,
})

map("i", "<C-z>", "<C-o>u", {
  desc = "Undo",
  silent = true,
})

map("n", "<C-y>", "<C-r>", {
  desc = "Redo",
  silent = true,
})

map("i", "<C-y>", "<C-o><C-r>", {
  desc = "Redo",
  silent = true,
})

-- ============================================================================
-- SELECT ALL
-- ============================================================================

map({ "n", "x" }, "<C-a>", "ggVG", {
  desc = "Select all",
  silent = true,
})

map("i", "<C-a>", "<Esc>ggVG", {
  desc = "Select all",
  silent = true,
})

-- ============================================================================
-- TEXT NAVIGATION
-- ============================================================================

-- Start/end of line
map("i", "<C-S-Left>", "<C-o>^", {
  desc = "Go to start of line",
  silent = true,
})

map("i", "<C-S-Right>", "<C-o>$", {
  desc = "Go to end of line",
  silent = true,
})

map("x", "<C-S-Left>", "^", {
  desc = "Go to start of line",
  silent = true,
})

map("x", "<C-S-Right>", "g_", {
  desc = "Go to end of line",
  silent = true,
})

-- ============================================================================
-- MOVE LINES
-- ============================================================================

map("i", "<C-S-Up>", "<Esc><Cmd>move .-2<CR>==gi", {
  desc = "Move line up",
  silent = true,
})

map("i", "<C-S-Down>", "<Esc><Cmd>move .+1<CR>==gi", {
  desc = "Move line down",
  silent = true,
})

map("x", "<C-S-Up>", ":move '<-2<CR>gv=gv", {
  desc = "Move selection up",
  silent = true,
})

map("x", "<C-S-Down>", ":move '>+1<CR>gv=gv", {
  desc = "Move selection down",
  silent = true,
})

-- Keep selection after indenting
map("x", "<", "<gv", {
  desc = "Indent left and keep selection",
  silent = true,
})

map("x", ">", ">gv", {
  desc = "Indent right and keep selection",
  silent = true,
})