#!/bin/bash

logHeader() {
    # Check terminal color support
    if [[ -t 1 ]]; then
        # Determine color based on terminal background
        if [[ "$TERM" == *"dark"* ]]; then
            local color="\033[1;31m"  # Red for dark terminals
        else
            local color="\033[1;34m"  # Blue for light terminals
        fi
        local reset="\033[0m"
    else
        local color=""
        local reset=""
    fi

    # Print SK3L3T0R ASCII art with color
    printf "${color}%s${reset}\n" "
                      ______________
                ,===:'.,            \`-._
                     \`:.\\\`---.__         \`-._
                       \`:.     \`--.         \`.
                         \\\.        \`.         \`.
                 (,,(,    \\\.         \`.   ____,-\`.,
              (,'     \`/   \\\.   ,--.___\`.'
          ,  ,'  ,--.  \`,   \\\.;'         \`
           \`{D, {    \\  :    \\;
             V,,'    /  /    //
             j;;    /  ,' ,-//.    ,---.      ,
             \\;'   /  ,' /  *  \\  /  *  \\   ,'/
                   \\   \`'  / \\  \`'  / \\  \`.' /
SK3L3T0R.S0FTW4RE   \`.___,'   \`.__,'   \`.__,'      v0.0.1"

    # Print additional ASCII text
    printf "${color}%s${reset}\n" "
▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀
██       █████  ███████ ██    ██ ██    ██ ██ ███    ███ 
██      ██   ██    ███   ██  ██  ██    ██ ██ ████  ████ 
██      ███████   ███     ████   ██    ██ ██ ██ ████ ██ 
██      ██   ██  ███       ██     ██  ██  ██ ██  ██  ██ 
███████ ██   ██ ███████    ██      ████   ██ ██      ██ 
                                                        
███████ ███████ ████████ ██    ██ ██████                
██      ██         ██    ██    ██ ██   ██               
███████ █████      ██    ██    ██ ██████                
     ██ ██         ██    ██    ██ ██                    
███████ ███████    ██     ██████  ██                    
▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀
   "
}


logHeader
set -e

echo "[SK3L3T0R] Installing base tools..."
brew install node python lua neovim ripgrep fd git jq

echo "[SK3L3T0R] Installing python support..."
if ! [ -d "$HOME/.lazyvim-python" ]; then
  python3 -m venv ~/.lazyvim-python
fi

source ~/.lazyvim-python/bin/activate

pip install --upgrade pip
pip install pynvim black

echo "[SK3L3T0R] Installing global Node tools..."
npm install -g \
  typescript typescript-language-server \
  @astrojs/language-server \
  vscode-langservers-extracted \
  prettier \
  bash-language-server \
  pyright \
  markdownlint \
  remark-language-server

echo "[SK3L3T0R] Installing Java LSP (Java +17 required)..."
brew install jdtls

echo "[SK3L3T0R] Installing Marksman (markdown)..."
brew install marksman

echo "[SK3L3T0R] Starting Neovim for LSPs install with Mason..."
nvim --headless "+Lazy! sync" +qa

echo "[SK3L3T0R] Installing LSPs with Mason..."
nvim --headless -c "luafile ~/.config/nvim/scripts/install-lsps.lua"
echo "[SK3L3T0R] Configuration completed!"
