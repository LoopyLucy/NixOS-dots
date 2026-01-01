#!/usr/bin/env bash

WALLPAPER_DIR="$HOME/Pictures/Backgrounds/"
CURRENT_WALL=$(hyprctl hyprpaper listloaded)

# Get a random wallpaper that is not the current one
WALLPAPER=$(find "$WALLPAPER_DIR" -type f ! -name "$(basename "$CURRENT_WALL")" | shuf -n 1)
WALLPAPER1=$(find "$WALLPAPER_DIR" -type f ! -name "$(basename "$WALLPAPER")" | shuf -n 1)
WALLPAPER2=$(find "$WALLPAPER_DIR" -type f ! -name "$(basename "$CURRENT_WALL")" ! -name "$(basename "$WALLPAPER1")" | shuf -n 1)

# Apply the selected wallpaper
hyprctl hyprpaper wallpaper "DP-1","$WALLPAPER"
hyprctl hyprpaper wallpaper "DP-2","$WALLPAPER1"
hyprctl hyprpaper wallpaper "HDMI-A-1","$WALLPAPER2"