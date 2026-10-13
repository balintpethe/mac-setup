#!/usr/bin/env bash

# ==============================================================================
# MacBook Developer Auto-Setup Script
# ==============================================================================
set -e

echo "🚀 Kezdődik a Mac fejlesztői környezet telepítése..."

# 1. Developer mappa létrehozása
echo "📁 ~/Developer mappa ellenőrzése..."
mkdir -p "$HOME/Developer"

# 2. Xcode Command Line Tools ellenőrzése / telepítése
if ! xcode-select -p &>/dev/null; then
    echo "🛠️ Xcode Command Line Tools telepítése..."
    xcode-select --install
    echo "⚠️ Kérlek hagyd jóvá a felugró ablakot, majd nyomj Entert a folytatáshoz ha kész!"
    read -r
else
    echo "✅ Xcode Command Line Tools már telepítve van."
fi

# 3. Homebrew telepítése és betöltése
if ! command -v brew &>/dev/null; then
    echo "🍺 Homebrew telepítése..."
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    
    # PATH beállítása Apple Silicon architektúrán
    if [[ -d "/opt/homebrew" ]]; then
        echo 'eval "$(/opt/homebrew/bin/brew shellenv zsh)"' >> "$HOME/.zprofile"
        eval "$(/opt/homebrew/bin/brew shellenv zsh)"
    fi
else
    echo "✅ Homebrew már elérhető."
fi

# 4. Csomagok telepítése Homebrew-val
echo "📦 GUI alkalmazások és CLI eszközök telepítése..."

CASK_APPS=(
    orbstack
    visual-studio-code
    google-chrome
)

CLI_TOOLS=(
    git
    gh
    mise
    jq
    ripgrep
    fzf
    btop
)

echo "-> GUI alkalmazások (Cask): ${CASK_APPS[*]}"
brew install --cask "${CASK_APPS[@]}"

echo "-> CLI eszközök: ${CLI_TOOLS[*]}"
brew install "${CLI_TOOLS[@]}"

# 5. Shell konfiguráció (~/.zshrc)
echo "⚙️ Shell integrációk (mise, fzf) beállítása..."
touch "$HOME/.zshrc"

if ! grep -q 'mise activate zsh' "$HOME/.zshrc"; then
    echo 'eval "$(mise activate zsh)"' >> "$HOME/.zshrc"
    echo "-> mise aktiválva a ~/.zshrc fájlban."
fi

if ! grep -q 'fzf --zsh' "$HOME/.zshrc"; then
    echo 'source <(fzf --zsh)' >> "$HOME/.zshrc"
    echo "-> fzf billentyűkombinációk aktiválva a ~/.zshrc fájlban."
fi

# 6. Node.js LTS beállítása mise-vel
echo "🟢 Node.js LTS telepítése mise segítségével..."
eval "$(mise activate bash)"
mise use --global node@lts

# 7. Claude Code CLI telepítése
echo "🤖 Claude Code CLI globális telepítése npm-mel..."
npm install -g @anthropic-ai/claude-code

# 8. Git alapbeállítások (ha még nincsenek beállítva)
echo "🔧 Git konfiguráció ellenőrzése..."
if [[ -z "$(git config --global user.name)" ]]; then
    read -rp "Add meg a teljes neved a Githez (pl. Pethe Bálint): " GIT_NAME
    git config --global user.name "$GIT_NAME"
fi

if [[ -z "$(git config --global user.email)" ]]; then
    read -rp "Add meg az email címed a Githez: " GIT_EMAIL
    git config --global user.email "$GIT_EMAIL"
fi

git config --global init.defaultBranch main

echo ""
echo "=============================================================================="
echo "🎉 Telepítés sikeresen befejeződött!"
echo "👉 Utolsó teendők:"
echo "   1. GitHub belépés és SSH kulcs generálása: futtasd a 'gh auth login' parancsot."
echo "   2. Nyisd meg az OrbStack alkalmazást az első engedélyek megadásához."
echo "   3. Indíts egy új terminál ablakot vagy futtasd: source ~/.zshrc"
echo "=============================================================================="