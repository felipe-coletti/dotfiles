#!/usr/bin/env bash
set -euo pipefail

REPO_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# 1. Instalar pacotes
sudo pacman -S --needed hyprland waybar foot wofi stow

# 2. Rodar stow UMA VEZ
cd "$REPO_DIR"
stow .config

echo "Dotfiles instalados!"