#!/bin/bash

WALLPAPER_DIR="$HOME/.config/GruvBox_Material"
CACHE_DIR="$HOME/.cache/wallpaper-thumbs"

mkdir -p "$CACHE_DIR"

# Generate thumbnails for rofi icons
for img in "$WALLPAPER_DIR"/*.{jpg,jpeg,png,gif}; do
    [ -f "$img" ] || continue
    filename=$(basename "$img")
    cache_file="$CACHE_DIR/$filename"
    if [ ! -f "$cache_file" ]; then
        convert "$img" -resize 500x500^ -gravity center -extent 500x500 "$cache_file"
    fi
done

# Build rofi menu entries (filename without path)
selection=$(
    for img in "$WALLPAPER_DIR"/*.{jpg,jpeg,png,gif}; do
        [ -f "$img" ] || continue
        filename=$(basename "$img")
        echo -en "$filename\x00icon\x1f$CACHE_DIR/$filename\n"
    done | rofi -dmenu \
        -p "Wallpaper" \
        -show-icons \
        -icon-size 100 \
        -theme-str 'listview { columns: 3; lines: 1; }' \
        -theme-str 'element { orientation: vertical; }' \
        -theme-str 'element-icon { size: 150px; }'
)

# Apply if something was selected
if [ -n "$selection" ]; then
    awww img "$WALLPAPER_DIR/$selection" \
        --transition-type grow \
        --transition-step 90
fi
