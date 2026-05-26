#!/bin/bash

# ============================================================
#  TERMUX-X-NVIM — Installer
#  https://github.com/NOTHING-R/TERMUX-X-NVIM
# ============================================================

set -e

REPO_URL="https://github.com/NOTHING-R/TERMUX-X-NVIM.git"
REPO_DIR="$HOME/TERMUX-X-NVIM"
CONFIG_DIR="$HOME/.config/nvim"
BACKUP_DIR="$HOME/.config/nvim.bak"

echo ""
echo "=================================================="
echo "  TERMUX-X-NVIM Installer"
echo "=================================================="
echo ""

# Step 1 — Ensure ~/.config exists (fresh Termux installs may not have it)
echo "[1/4] Ensuring ~/.config directory exists..."
mkdir -p "$HOME/.config"

# Step 2 — Back up any existing Neovim config
if [ -d "$CONFIG_DIR" ]; then
  echo "[2/4] Existing Neovim config found. Backing up to ~/.config/nvim.bak ..."
  rm -rf "$BACKUP_DIR"
  mv "$CONFIG_DIR" "$BACKUP_DIR"
  echo "      Backup saved to: $BACKUP_DIR"
else
  echo "[2/4] No existing Neovim config found. Skipping backup."
fi

# Step 3 — Clone the repository (or update if already cloned)
if [ -d "$REPO_DIR/.git" ]; then
  echo "[3/4] Repository already cloned. Pulling latest changes..."
  git -C "$REPO_DIR" pull
else
  echo "[3/4] Cloning TERMUX-X-NVIM repository..."
  git clone "$REPO_URL" "$REPO_DIR"
fi

# Step 4 — Copy config into place
echo "[4/4] Copying config to ~/.config/nvim ..."
cp -r "$REPO_DIR/nvim" "$CONFIG_DIR"

echo ""
echo "=================================================="
echo "  Installation complete!"
echo "=================================================="
echo ""
echo "  Run 'nvim' to launch Neovim."
echo "  On first launch, lazy.nvim will install all plugins automatically."
echo "  Wait for it to finish, then restart Neovim with ':qa' and 'nvim'."
echo ""
