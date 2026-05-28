# Generate files (Adjust target directory as needed)
    FILE_LIST=$(${pkgs.findutils}/bin/find ~ -maxdepth 3 -type f 2>/dev/null)

    # Launch rofi
    CHOICE=$(echo "$FILE_LIST" | rofi -dmenu -p "Search Files:")
    EXIT_STATUS=$?

    # Handle actions based on mouse clicks
    if [ "$EXIT_STATUS" -eq 0 ] && [ -n "$CHOICE" ]; then
        # Left-click / Enter: Open file
        ${pkgs.xdg-utils}/bin/xdg-open "$CHOICE"
    elif [ "$EXIT_STATUS" -eq 10 ] && [ -n "$CHOICE" ]; then
        # Right-click: Open the file's parent location
        PARENT_DIR=$(${pkgs.findutils}/bin/dirname "$CHOICE")
        ${pkgs.xdg-utils}/bin/xdg-open "$PARENT_DIR"
    fi