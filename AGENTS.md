# Repository Guidelines

## Project Structure & Module Organization
This LazyVim profile lives in `~/.config/nvim`. `init.lua` bootstraps `lua/config/*.lua` (options, keymaps, lazy setup, autocmds, and the `.nvim.lua` generator) and enforces the Tokyo Night scheme plus local config loading. Plugin specs belong in `lua/plugins/` (split by theme, UI, etc.), while language-specific tweaks live in `lua/langs/<stack>.lua` and are required from per-project `.nvim.lua` files. Bootstrap scripts stay under `scripts/`, agent docs under `skills/`, and LazyVim metadata in `lazyvim.json`. There is no standalone `tests/`; exercise modules through Neovim itself.

## Build, Test, and Development Commands
- `bash scripts/lazyvim-setup.sh` — installs brew, Python, Node, and jq/fd/rg plus global LSP binaries; run after cloning or when onboarding a new machine.
- `nvim --headless "+Lazy! sync" +qa` — resolves plugin specs in `lua/plugins/` and surfaces syntax issues before interactive use.
- `nvim --headless -c "luafile ~/.config/nvim/scripts/install-lsps.lua"` — uses Mason to install the servers listed in `scripts/install-lsps.lua`.
- `:GenerateNvimConfigFile` — scaffolds `.nvim.lua` for the current project so you can enumerate the languages to load from `lua/langs/`.
- `nvim --headless "+checkhealth" +qa` — confirms providers, Treesitter parsers, and external executables after dependency bumps.

## Coding Style & Naming Conventions
Format Lua with `stylua .` (2-space indent, 120-column width per `stylua.toml`). Export plugin specs via `return { ... }` and helpers via `local M = {}`; keep filenames aligned to the feature (`langs/python.lua`, `plugins/colorscheme.lua`). Use snake_case for locals, PascalCase for Neovim user commands, and include concise descriptions on every keymap. Prefer `vim.notify` for user feedback and keep option changes near their related plugin definitions.

## Testing Guidelines
Validate loaders headlessly (`nvim --headless -u init.lua "+lua require('config.lazy')" +qa`) after any change in `lua/config` or `lua/plugins`. For every new language module, require it directly (`nvim --headless "+lua require('langs.angular')" +qa`) before referencing it in a `.nvim.lua`. Run `:Lazy health` or `:checkhealth` whenever scripts add dependencies, and note any manual install steps in PRs. Keep Mason server lists synchronized with `scripts/install-lsps.lua` so health checks remain clean.

## Commit & Pull Request Guidelines
The upstream history follows Conventional Commits (`feat(lang): add astro snippets`, `fix(config): guard local config loader`); continue that pattern and limit each commit to a focused concern. Before opening a PR, run Stylua and the headless health commands, then describe what changed, how to test (`nvim --headless "+Lazy! sync"`), and any screenshots for UI tweaks. Link related issues or TODOs, mention new dependencies (brew/npm/pip), and call out whether users must regenerate `.nvim.lua` templates.

## Security & Configuration Tips
Because `init.lua` enables `exrc`+`secure`, Neovim will automatically execute `.nvim.lua` files in project roots—review them before opening untrusted workspaces. Avoid storing secrets in this repo; rely on environment variables or tool-specific config outside `~/.config/nvim`. When sharing scripts, scrub machine-specific paths and keep the dependency list minimal to reduce supply-chain surface area.
