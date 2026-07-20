#!/usr/bin/env bash
# Applies a theme across every app: writes the central state file, then
# rewrites each app's colors.* pointer file to import that theme's palette.
#
# Usage: set-theme.sh <theme-name>
# e.g.:  set-theme.sh catppuccin

set -euo pipefail

theme="${1:-}"
if [ -z "$theme" ]; then
    echo "Usage: set-theme.sh <theme-name>" >&2
    exit 1
fi

# ---- paths - adjust these if your dotfiles live somewhere else ----
CENTRAL_STATE="$HOME/.config/current-theme"
HYPR_COLORS="$HOME/.config/hypr/colors/colors.lua"
KITTY_COLORS="$HOME/.config/kitty/colors/colors.conf"
ROFI_COLORS="$HOME/.config/rofi/colors/colors.rasi"
WLOGOUT_COLORS="$HOME/.config/wlogout/colors/colors.css"
WAYBAR_COLORS="$HOME/.config/waybar/colors/colors.css"
WALLPAPER_ROOT="$HOME/.config/wallpapers"

# 1. Write the central state file - this is what wallpaper-picker.sh
#    and Neovim's config/theme.lua both read to know the active theme.
echo "$theme" > "$CENTRAL_STATE"

# 2. Hyprland - colors.lua just requires the matching palette module.
echo "return require(\"colors.custom.$theme\")" > "$HYPR_COLORS"

# 3. Kitty - colors.conf includes the matching palette file.
#    Path is relative to colors.conf itself (custom/<theme>.conf).
echo "include custom/$theme.conf" > "$KITTY_COLORS"

# 4. Waybar - colors.css includes the matching palette file
echo "@import url(\"custom/$theme.css\");" > "$WAYBAR_COLORS"

# 5. Rofi - colors.rasi imports the palette, then the shared widget rules.
#    Order matters: variables must be defined before common.rasi uses them.
{
    echo "@import \"custom/$theme.rasi\""
    echo "@import \"common.rasi\""
} > "$ROFI_COLORS"

# 6. wlogout - same @import pattern as rofi, GTK CSS flavor.
echo "@import url(\"custom/$theme.css\");" > "$WLOGOUT_COLORS"

# 7. Reload what needs reloading.
#    Hyprland picks up the Lua change automatically on save, but a
#    reload is cheap insurance.
hyprctl reload

#    Kitty reloads its config on SIGUSR1. This signals every running
#    kitty instance.
pkill -SIGUSR1 kitty 2>/dev/null || true

#    Rofi and wlogout read their config fresh each launch - nothing to do.
#    Neovim reads current-theme on next startup - nothing to do for
#    already-open instances.

# Waybar reloads on SIGUSR2
pkill waybar
waybar >/dev/null 2>&1 & disown

# 8. Pick a default wallpaper for this theme and apply it.
theme_wall_dir="$WALLPAPER_ROOT/$theme"
if [ -d "$theme_wall_dir" ]; then
    default_wall=$(find "$theme_wall_dir" -maxdepth 1 -type f \
        \( -iname "*.jpg" -o -iname "*.jpeg" -o -iname "*.png" -o -iname "*.gif" \) \
        | shuf -n 1)
    if [ -n "$default_wall" ]; then
        awww img "$default_wall" --transition-type grow --transition-step 90
        echo "$WALLPAPER_DIR/$selection" > "$HOME/.cache/current-wallpaper"
    else
        notify-send "Theme" "No wallpapers found in $theme_wall_dir"
    fi
else
    notify-send "Theme" "No wallpaper folder for '$theme' at $theme_wall_dir"
fi

notify-send "Theme" "Switched to: $theme"
