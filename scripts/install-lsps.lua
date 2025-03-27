local mason_registry = require("mason-registry")

local servers = {
  "pyright",
  "tsserver",
  "astro",
  "angularls",
  "bash-language-server",
  "jdtls",
  "marksman",
}

local installs_remaining = 0

local function check_and_exit()
  if installs_remaining <= 0 then
    vim.schedule(function()
      vim.cmd("qa")
    end)
  end
end

for _, name in ipairs(servers) do
  local ok, pkg = pcall(mason_registry.get_package, name)
  if ok and not pkg:is_installed() then
    installs_remaining = installs_remaining + 1
    pkg:install():once("closed", function()
      installs_remaining = installs_remaining - 1
      check_and_exit()
    end)
  end
end

-- Si ya estaban todos instalados
check_and_exit()
