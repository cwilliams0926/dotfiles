#!/usr/bin/env bash

DECOR_DIR="$HOME/.config/hypr/modules/decorations"
CURRENT_LINK="$DECOR_DIR/current.lua"

choice=$(printf "rounded\nboxed" | rofi -dmenu -p "Change Decoration")

[ -z "$choice" ] && exit 0

ln -sf "$DECOR_DIR/$choice.lua" "$CURRENT_LINK"
hyprctl reload
notify-send "Hyprland" "Decorations switched to: $choice"
