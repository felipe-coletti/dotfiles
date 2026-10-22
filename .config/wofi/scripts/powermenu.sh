#!/bin/bash

lang="${LC_ALL:-${LC_MESSAGES:-$LANG}}"

case "$lang" in
  pt*)
    shutdown="Desligar"
    reboot="Reiniciar"
    lock="Bloquear"
    logout="Sair"
    prompt="Buscar"
    ;;
  *)
    shutdown="Shut down"
    reboot="Reboot"
    lock="Lock"
    logout="Log out"
    prompt="Search"
    ;;
esac

chosen=$(printf '%s\n' "$shutdown" "$reboot" "$lock" "$logout" | wofi --dmenu --prompt "$prompt" --width 300 --height 200 -i)

case "$chosen" in
  "$shutdown") systemctl poweroff ;;
  "$reboot")   systemctl reboot ;;
  "$lock")     hyprlock ;;
  "$logout")   uwsm stop ;;
esac
