```ts
██       █████  ███████ ██    ██ ██    ██ ██ ███    ███
██      ██   ██    ███   ██  ██  ██    ██ ██ ████  ████
██      ███████   ███     ████   ██    ██ ██ ██ ████ ██
██      ██   ██  ███       ██     ██  ██  ██ ██  ██  ██
███████ ██   ██ ███████    ██      ████   ██ ██      ██
\...SK3L3T0R...v0.0.1......./
```

This guide provides concise instructions on configuring LazyVim using .nvim.lua files and demonstrates how to set up custom keybindings.​

Neovim allows for project-specific configurations using the .nvim.lua file. By placing this file in your project's root directory, you can tailor Neovim's behavior to meet the specific needs of each project.

# Custom Scripts
#### Create Nvim local config file
Use this command in nvim for generate a local config file (`.nvim.lua`) for your current project.

```lua
:GenerateNvimConfigFile
```


# Keybindings Overview

#### Window Navigation

- Ctrl+Shift+Right: Move focus to the window on the right.​
- Ctrl+Shift+Left: Move focus to the window on the left.​

#### File Operations

- Ctrl+Shift+S: Save the current file in both normal and insert modes.​

#### Line Navigation in Insert Mode

- Ctrl+Shift+Left: Move cursor to the beginning of the line.​
- Ctrl+Shift+Right: Move cursor to the end of the line.​

#### Line Navigation in Visual Mode

- Ctrl+Shift+Left: Move cursor to the beginning of the line.​
- Ctrl+Shift+Right: Move cursor to the end of the line.​

#### Line Movement

- Alt+Up: Move the current line or selected block up.​
- Alt+Down: Move the current line or selected block down.​

> Some terminal environments may not distinguish between certain key combinations (e.g.,
> Ctrl+Shift variants). If a keybinding does not work as expected, consider using alternative
> combinations or consulting your terminal's documentation.

<p align="right">(<a href="#top">back to top</a>)</p>

# Project-Specific Configuration

This guide outlines how to set up project-specific configurations in Neovim using LazyVim. By leveraging the `.nvim.lua` file within your project directories, you can tailor Neovim's behavior to suit the unique requirements of each project.

### Overview

Neovim allows for local configurations on a per-project basis through the use of the `exrc` option. When enabled, Neovim searches for configuration files like `.nvim.lua` or `.exrc` in the current directory and executes them. This feature facilitates the customization of settings, plugins, and behaviors specific to individual projects.

**Security Consideration:** Enabling the exrc option can pose security risks, as it allows the execution of arbitrary code from local configuration files. To mitigate this, also enable the `secure` option, which restricts the execution of potentially unsafe commands in these local configs.

## Enabling Local Configurations

To allow Neovim to load project-specific configurations:

1. **Enable the `exrc` Option:** This tells Neovim to look for local configuration files in the current directory.

2. **Enable the `secure` Option:** This restricts the execution of potentially unsafe commands in local configuration files.

Add the following lines to your main Neovim configuration file (e.g., init.lua):

```lua
-- Enable loading of local config files
vim.o.exrc = true

-- Restrict unsafe commands in local configs
vim.o.secure = true
```

## Creating a Project-Specific Configuration

Within the root directory of your project, create a `.nvim.lua` file. This file will contain the configurations specific to that project. For example, to load configurations for technologies like Angular, Ionic, Capacitor, TypeScript, HTML, and SCSS, you can specify them in an array and load them accordingly.

#### Example `.nvim.lua`

```lua
-- List of technologies used in the project
local techs = {
  "angular",
  "ionic",
  "capacitor",
  "typescript",
  "html",
  "scss",
}

-- Load the corresponding configuration modules
for _, tech in ipairs(techs) do
  local ok, err = pcall(require, "langs." .. tech)
  if not ok then
    vim.notify("Error loading config for " .. tech .. ": " .. err, vim.log.levels.ERROR)
  end
end
```

In this setup:

- The `techs` table lists all the technologies relevant to the project.
- The loop iterates over each technology and attempts to require its corresponding configuration module from the `langs` directory.
- If a module fails to load, an error message is displayed using `vim.notify`.

## Organizing Language-Specific Configurations

To keep configurations modular and maintainable, create a `langs` directory within your Neovim configuration directory (typically `~/.config/nvim/lua/langs/`). Each file in this directory should correspond to a specific technology or language and contain its configuration settings.

#### Example Structure

```
~/.config/nvim/lua/langs/
├── angular.lua
├── ionic.lua
├── capacitor.lua
├── typescript.lua
├── html.lua
└── scss.lua
```

#### Example Content for `angular.lua`

```lua
local lspconfig = require("lspconfig")

-- Configure Angular Language Server
lspconfig.angularls.setup({
  root_dir = lspconfig.util.root_pattern("angular.json", "project.json"),
  -- Additional settings specific to Angular projects
})

```

Repeat this pattern for other technologies, customizing each configuration file as needed.

<p align="right">(<a href="#top">back to top</a>)</p>

## Security Best Practices

When using local configuration files:

- **Review `.nvim.lua` Files:** Before opening a project, inspect its `.nvim.lua` file to ensure it doesn't contain malicious code.
- **Use Version Control:** Track changes to configuration files using version control systems like Git to monitor and review modifications.
- **Restrict Permissions:** Limit write permissions to project directories to trusted users to prevent unauthorized changes to configuration files.

By following these practices, you can safely utilize project-specific configurations in Neovim.

<p align="right">(<a href="#top">back to top</a>)</p>
