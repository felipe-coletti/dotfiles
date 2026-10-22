#!/usr/bin/env bash
# Seleciona os textos do idioma do sistema (fallback: en_US) e inicia o waybar

dir="$HOME/.config/waybar/i18n"
lang="${LC_ALL:-${LC_MESSAGES:-$LANG}}"
lang="${lang%%.*}"

# Idioma exato (pt_BR) → mesmo idioma de outra região (pt_PT → pt_BR) → en_US
if [[ ! -f "$dir/$lang.jsonc" ]]; then
    match=$(compgen -G "$dir/${lang%%_*}_*.jsonc" | head -n 1)
    lang=$(basename "${match:-en_US.jsonc}" .jsonc)
fi

ln -sf "$lang.jsonc" "$dir/current.jsonc"

exec waybar "$@"
