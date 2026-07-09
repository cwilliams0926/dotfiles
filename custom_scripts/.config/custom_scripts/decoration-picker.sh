#!/usr/bin/env bash
# ~/.config/hypr/scripts/decoration-switcher.sh

DECOR_DIR="$HOME/.config/hypr/modules/decorations"
CURRENT_LINK="$DECOR_DIR/current.lua"

choice=$(printf "rounded\nboxed" | rofi -dmenu -p "Decoration style")

[ -z "$choice" ] && exit 0

ln -sf "$DECOR_DIR/$choice.lua" "$CURRENT_LINK"
hyprctl reload
notify-send "Hyprland" "Decorations switched to: $choice"
