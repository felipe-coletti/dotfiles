#!/usr/bin/env bash
# install.sh — Instalação dos dotfiles Arch + Hyprland

set -euo pipefail

# ─── Cores ──────────────────────────────────────────────────
readonly RED='\033[0;31m' GREEN='\033[0;32m' YELLOW='\033[1;33m'
readonly BLUE='\033[0;34m' NC='\033[0m'

# ─── Helpers ────────────────────────────────────────────────
log()     { printf "%b\n" "$1"; }
ok()      { log "${GREEN}✔${NC} $1"; }
warn()    { log "${YELLOW}⚠${NC} $1"; }
err()     { log "${RED}✖${NC} $1"; }
section() { log "\n${BLUE}── $1 ──${NC}"; }

# ─── Caminhos ───────────────────────────────────────────────
readonly REPO_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
readonly BACKUP_DIR="$HOME/.dotfiles-backup-$(date +%Y%m%d-%H%M%S)"
readonly CONFIG_DIR="$HOME/.config"

readonly PKGS=(
    hyprland waybar foot thunar wofi mako hyprpaper
    playerctl brightnessctl wireplumber pipewire
    ttf-jetbrains-mono-nerd ttf-font-awesome git
    papirus-icon-theme noto-fonts-emoji
)

# ─── 1. Verificar pré-requisitos ─────────────────────────────
check_prereqs() {
    section "Verificando pré-requisitos"

    if [[ ! -f /etc/arch-release ]]; then
        warn "Este script foi feito para Arch Linux."
    fi

    if ! command -v git &>/dev/null; then
        err "git não encontrado."
        exit 1
    fi

    ok "Pré-requisitos verificados."
}

# ─── 2. Instalar pacotes ────────────────────────────────────
install_packages() {
    section "Instalando pacotes"

    local missing=()
    for pkg in "${PKGS[@]}"; do
        if ! pacman -Qi "$pkg" &>/dev/null; then
            missing+=("$pkg")
        fi
    done

    if ((${#missing[@]})); then
        log "Pacotes faltando: ${missing[*]}"
        sudo pacman -S --needed --noconfirm "${missing[@]}"
        ok "Pacotes instalados."
    else
        ok "Todos os pacotes já estão instalados."
    fi
}

# ─── 3. Backup de configs existentes ────────────────────────
backup_existing() {
    section "Backup de configs existentes"

    local has_backup=false
    for dir in hypr waybar foot mako wofi hyprpaper colors; do
        local target="$CONFIG_DIR/$dir"
        if [[ -e "$target" ]]; then
            mkdir -p "$BACKUP_DIR"
            cp -r "$target" "$BACKUP_DIR/"
            has_backup=true
            warn "Backup: $target"
        fi
    done

    if $has_backup; then
        ok "Backup salvo em $BACKUP_DIR"
    else
        ok "Sem backups necessários."
    fi
}

# ─── 4. Copiar configurações ────────────────────────────────
copy_config() {
    section "Copiando configurações"

    mkdir -p "$CONFIG_DIR"

    for dir in hypr waybar foot mako wofi hyprpaper colors; do
        local src="$REPO_DIR/.config/$dir"
        local dst="$CONFIG_DIR/$dir"

        if [[ -d "$src" ]]; then
            rm -rf "$dst"
            cp -r "$src" "$dst"
            ok "Copiado: $dir"
        else
            warn "Pasta não encontrada: $src"
        fi
    done
}

# ─── 5. Ajustes finais ──────────────────────────────────────
post_install() {
    section "Ajustes finais"

    chmod +x "$REPO_DIR/install.sh"
    mkdir -p "$HOME/Pictures/screenshots"

    ok "Instalação concluída."
}

# ─── 6. Resumo ──────────────────────────────────────────────
summary() {
    log "\n${GREEN}════════════════════════════════════${NC}"
    log "${GREEN}  Dotfiles instalados com sucesso!  ${NC}"
    log "${GREEN}════════════════════════════════════${NC}"
    log ""
    log "Para testar:"
    log "  ${BLUE}hyprctl reload${NC}"
    log "  ${BLUE}killall -SIGUSR2 waybar${NC}"
    log ""
    log "Se algo deu errado, restaure o backup:"
    log "  ${BLUE}cp -r $BACKUP_DIR/* ~/.config/${NC}"
}

# ─── Main ───────────────────────────────────────────────────
main() {
    log "${BLUE}╔══════════════════════════════════════╗${NC}"
    log "${BLUE}║   Dotfiles Arch + Hyprland Installer ║${NC}"
    log "${BLUE}╚══════════════════════════════════════╝${NC}"

    check_prereqs
    install_packages
    backup_existing
    copy_config
    post_install
    summary
}

main "$@"