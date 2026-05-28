#!/bin/bash

# 1. Parse command line inputs for the mode
mode="region" # default behavior
case "$1" in
    -f|--full)   mode="full" ;;
    -w|--window) mode="window" ;;
    -r|--region) mode="region" ;;
esac

# 2. Get the active window name for the folder structure
if command -v hyprctl &> /dev/null; then
    active_window=$(hyprctl activewindow | awk '/class:/ {print $2; exit}')
elif command -v swaymsg &> /dev/null; then
    active_window=$(swaymsg -t get_tree | grep -B 10 '"focused": true' | grep -E '"app_id"|"name"' | grep -v "null" | tail -n 1 | awk -F'"' '{print $4}')
else
    active_window="Desktop"
fi

if [ -z "$active_window" ]; then
    active_window="Desktop"
fi

# 3. Sanitize name using native bash substitution (Shellcheck-friendly)
safe_window_name="${active_window//[^a-zA-Z0-9_-]/_}"

# 4. Set paths and export for subshells
folderName="$HOME/Pictures/Screenshots/$safe_window_name"
fileName="$(date +"%Y-%m-%d_%H:%M:%S").png"
fullPath="$folderName/$fileName"
export fullPath

mkdir -p "$folderName"

# 5. Define capture functions
function capture_region() {
    set -e
    local slurp_output
    slurp_output=$(slurp -f '%x %y %w %h' -d -b 00000060 -c b4befeff)
    if [ -z "$slurp_output" ]; then exit 0; fi # Handles Escape/Cancel
    
    local x y w h
    read -r x y w h <<< "$slurp_output"
    
    local sx sy
    sx=$(((x+2)/4*4))
    sy=$(((y+2)/4*4))
    w=$((w+x-sx))
    h=$((h+y-sy))

    grim -g "${sx},${sy} ${w}x${h}" "$fullPath"
}
export -f capture_region

function capture_window() {
    set -e
    local geoms=""
    if command -v hyprctl &> /dev/null; then
        # Dynamically find the current active workspace to prevent selecting background windows
        local active_ws
        active_ws=$(hyprctl activewindow | awk '/workspace:/ {print $2; exit}')
        
        # Fixed coordinate parsing split logic
        geoms=$(hyprctl clients | awk -v ws="$active_ws" '/at:/ {split($2,a,","); x=a[1]; y=a[2]} /size:/ {split($2,s,","); w=s[1]; h=s[2]} /workspace:/ {if ($2 == ws) print x "," y " " w "x" h}')
    elif command -v swaymsg &> /dev/null && command -v jq &> /dev/null; then
        geoms=$(swaymsg -t get_tree | jq -r '.. | select(.pid? and .visible?) | "\(.rect.x),\(.rect.y) \(.rect.width)x\(.rect.height)"')
    fi

    local slurp_output
    if [ -n "$geoms" ]; then
        slurp_output=$(echo "$geoms" | slurp -f '%x %y %w %h' -d -b 00000060 -c b4befeff)
    else
        slurp_output=$(slurp -f '%x %y %w %h' -d -b 00000060 -c b4befeff)
    fi

    if [ -z "$slurp_output" ]; then exit 0; fi # Handles Escape/Cancel
    
    local x y w h
    read -r x y w h <<< "$slurp_output"

    local sx sy
    sx=$(((x+2)/4*4))
    sy=$(((y+2)/4*4))
    w=$((w+x-sx))
    h=$((h+y-sy))

    grim -g "${sx},${sy} ${w}x${h}" "$fullPath"
}
export -f capture_window

# 6. Execution Router
if [ "$mode" == "full" ]; then
    grim "$fullPath"
elif [ "$mode" == "window" ]; then
    if command -v still &> /dev/null; then
        still -p -c capture_window
    else
        capture_window
    fi
else
    if command -v still &> /dev/null; then
        still -p -c capture_region
    else
        capture_region
    fi
fi

# 7. Exit if canceled
if [ ! -f "$fullPath" ]; then
    exit
fi

# 8. Clipboard and Notification
wl-copy < "$fullPath"

action=$(notify-send "Saved and copied $fileName" -i "$fullPath" -u low -t 5000 \
    --action view=View --action "satty=Edit (Satty)" --action "gimp=Edit (GIMP)" --action "copyPath=Copy Path")
case "$action" in
    "view" )
        xdg-open "$fullPath"
    ;;
    "satty" )
        satty -f "$fullPath" -o "$fullPath"
    ;;
    "gimp" )
        gimp "$fullPath"
    ;;
    "copyPath" )
        echo -n "$fullPath" | wl-copy
    ;;
esac