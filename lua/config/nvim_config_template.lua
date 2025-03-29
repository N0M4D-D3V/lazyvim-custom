local M = {}

M.create_nvim_lua = function()
  local filename = ".nvim.lua"
  local filepath = vim.fn.getcwd() .. "/" .. filename

  if vim.fn.filereadable(filepath) == 1 then
    vim.notify(filename .. " exists!", vim.log.levels.WARN)
    return
  end

  local template = [[
-- 🧠 Local Configuration file for Neovim
-- Use it for define specific configurations for this project!

-- Tech stack used in this project. Choose what u modules
local techs = {
  "angular",
  "ionic",
  "capacitor",
  "astro",
  "typescript",
  "java",
  "python",
  "html",
  "css",
  "markdown",
  "bash",
}

-- Load config modules
for _, tech in ipairs(techs) do
  local ok, err = pcall(require, "langs." .. tech)
  if not ok then
    vim.notify("Error loading config for " .. tech .. ": " .. err, vim.log.levels.ERROR)
  end
end
  ]]

  local file = io.open(filepath, "w")
  if file then
    file:write(template)
    file:close()
    vim.notify("File " .. filename .. " created!", vim.log.levels.INFO)
    vim.cmd("edit " .. filename)
  else
    vim.notify("Error generating the file", vim.log.levels.ERROR)
  end
end

vim.api.nvim_create_user_command("GenerateNvimConfigFile", function()
  M.create_nvim_lua()
end, {})

return M
