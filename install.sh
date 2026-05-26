#!/bin/bash

# ============================================================
#  TERMUX-X-NVIM — Full Installer
#  https://github.com/NOTHING-R/TERMUX-X-NVIM
#  Run this once after setting up Termux.
# ============================================================

set -e

REPO_URL="https://github.com/NOTHING-R/TERMUX-X-NVIM.git"
REPO_DIR="$HOME/TERMUX-X-NVIM"
CONFIG_DIR="$HOME/.config/nvim"
BACKUP_DIR="$HOME/.config/nvim.bak"
FONT_DIR="$HOME/.termux"
FONT_ZIP="$FONT_DIR/JetBrainsMono.zip"
FONT_URL="https://github.com/ryanoasis/nerd-fonts/releases/latest/download/JetBrainsMono.zip"

# ── Helpers ────────────────────────────────────────────────
GREEN="\033[1;32m"
YELLOW="\033[1;33m"
RED="\033[1;31m"
RESET="\033[0m"

step() { echo -e "\n${GREEN}==>${RESET} $1"; }
warn() { echo -e "${YELLOW}[!]${RESET} $1"; }
die() {
  echo -e "${RED}[✗] $1${RESET}"
  exit 1
}

# ── Banner ─────────────────────────────────────────────────
echo ""
echo -e "${GREEN}"
echo "  ████████╗███████╗██████╗ ███╗   ███╗██╗   ██╗██╗  ██╗"
echo "     ██╔══╝██╔════╝██╔══██╗████╗ ████║██║   ██║╚██╗██╔╝"
echo "     ██║   █████╗  ██████╔╝██╔████╔██║██║   ██║ ╚███╔╝ "
echo "     ██║   ██╔══╝  ██╔══██╗██║╚██╔╝██║██║   ██║ ██╔██╗ "
echo "     ██║   ███████╗██║  ██║██║ ╚═╝ ██║╚██████╔╝██╔╝ ██╗"
echo "     ╚═╝   ╚══════╝╚═╝  ╚═╝╚═╝     ╚═╝ ╚═════╝ ╚═╝  ╚═╝"
echo -e "${RESET}"
echo "         TERMUX-X-NVIM  ·  Full Auto Installer"
echo ""

# ── Step 1: Update packages ────────────────────────────────
step "Updating package lists..."
pkg update -y && pkg upgrade -y

# ── Step 2: Install core Termux packages ───────────────────
step "Installing core packages (git, curl, wget, unzip)..."
pkg install git curl wget unzip -y

# ── Step 3: Install Neovim ─────────────────────────────────
step "Installing Neovim..."
pkg install neovim -y

# ── Step 4: Install supporting tools ───────────────────────
step "Installing Node.js (required for LSP servers, live-server, Copilot)..."
pkg install nodejs -y

step "Installing Python (required for pyright LSP)..."
pkg install python -y

step "Installing ripgrep (required for Telescope live grep)..."
pkg install ripgrep -y

step "Installing Lua language server (for Lua formatting)..."
pkg install lua-language-server -y

# ── Step 5: Install npm globals ────────────────────────────
step "Installing markdown-toc (for TOC keymap)..."
npm install -g markdown-toc

step "Installing live-server (for live browser reload)..."
npm install -g live-server

# ── Step 6: Install JetBrainsMono Nerd Font ────────────────
# Required — without this, all icons in Neo-tree, statusline,
# dashboard, and LSP signs will show as broken boxes.
step "Installing JetBrainsMono Nerd Font..."
mkdir -p "$FONT_DIR"
echo "    Downloading font from GitHub..."
wget -q --show-progress -O "$FONT_ZIP" "$FONT_URL"
echo "    Unzipping..."
unzip -q -o "$FONT_ZIP" -d "$FONT_DIR"
echo "    Setting font.ttf..."
cp "$FONT_DIR/JetBrainsMonoNerdFont-Regular.ttf" "$FONT_DIR/font.ttf"
echo "    Cleaning up zip..."
rm -f "$FONT_ZIP"
echo "    Reloading Termux settings..."
termux-reload-settings
echo "    Font installed successfully."

# ── Step 7: Ensure ~/.config exists ───────────────────────
step "Ensuring ~/.config directory exists..."
mkdir -p "$HOME/.config"

# ── Step 8: Back up existing Neovim config if any ─────────
if [ -d "$CONFIG_DIR" ]; then
  warn "Existing Neovim config found. Backing up to ~/.config/nvim.bak ..."
  rm -rf "$BACKUP_DIR"
  mv "$CONFIG_DIR" "$BACKUP_DIR"
  echo "    Backup saved → $BACKUP_DIR"
else
  echo "    No existing config found — skipping backup."
fi

# ── Step 9: Clone or update the repo ──────────────────────
if [ -d "$REPO_DIR/.git" ]; then
  step "Repository already exists. Pulling latest changes..."
  git -C "$REPO_DIR" pull
else
  step "Cloning TERMUX-X-NVIM repository..."
  git clone "$REPO_URL" "$REPO_DIR"
fi

# ── Step 10: Copy config into place ───────────────────────
step "Copying config to ~/.config/nvim ..."
cp -r "$REPO_DIR/nvim" "$CONFIG_DIR"

# ── Step 11: Verify Neovim ────────────────────────────────
step "Verifying Neovim installation..."
nvim --version | head -1

# ── Done ──────────────────────────────────────────────────
echo ""
echo -e "${GREEN}============================================${RESET}"
echo -e "${GREEN}  ✓  Installation complete!${RESET}"
echo -e "${GREEN}============================================${RESET}"
echo ""
echo "  Next steps:"
echo "    1. Run:  nvim"
echo "    2. Wait for lazy.nvim to install all plugins automatically."
echo "    3. Once done, press 'q' to close the plugin window."
echo "    4. Restart Neovim:  :qa  then run nvim again"
echo "    5. You should see the custom dashboard. You're all set!"
echo ""
