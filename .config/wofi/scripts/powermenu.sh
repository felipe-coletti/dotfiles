#!/bin/bash

shutdown="Desligar"
reboot="Reiniciar"
lock="Bloquear"
logout="Sair"

chosen=$(printf '%s\n' "$shutdown" "$reboot" "$lock" "$logout" | wofi --dmenu --prompt "Buscar" --width 300 --height 200 -i)

case "$chosen" in
  "$shutdown") systemctl poweroff ;;
  "$reboot")   systemctl reboot ;;
  "$lock")     hyprlock ;;
  "$logout")   uwsm stop ;;
esac