#!/usr/bin/env bash
# Top-level "Change appearance" menu.

# Resolve the directory this script lives in, so it can find its siblings
# regardless of where it's called from.
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

choice=$(printf "Decorations\nWallpaper\nTheme" | rofi -dmenu -p "Change appearance")

# Empty choice means the user hit Escape - just exit quietly.
[ -z "$choice" ] && exit 0

case "$choice" in
    "Decorations")
        "$SCRIPT_DIR/decoration-picker.sh"
        ;;
    "Wallpaper")
        "$SCRIPT_DIR/wallpaper-picker.sh"
        ;;
    "Theme")
        "$SCRIPT_DIR/theme-picker.sh"
        ;;
esac
