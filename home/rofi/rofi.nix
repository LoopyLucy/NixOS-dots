{ config, lib, ... }:

let
	inherit (import ../hyprland/lua_utils.nix { inherit lib; })
        luaify lambda call bind_flags bind bind_exec with_flags on_startup;
    inherit (config.lib.formats.rasi) mkLiteral;
in {

	home.packages = [
		(pkgs.writeShellScriptBin "rofi-file-launcher" ''
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
		'')
	];

	xdg.configFile."rofi/colours.rasi".source = ./colours.rasi;
	xdg.configFile."rofi/style.rasi".source = ./style.rasi;

    programs.rofi = {
    	enable = true;
		font = "JetBrainsMono Nerd Font SemiBold 11";
		theme = "~/.config/rofi/style.rasi";
		extraConfig = {
			me-select-entry = "MousePrimary";
			me-accept-custom = "MouseSecondary";
			kb-custom-1 = "Control+MouseSecondary";
  		};
    };

    wayland.windowManager.hyprland.settings = {
		window_rule = [
			{ match.class = "^Rofi$"; stay_focused = true; rounding = 0; }
		];
		bind = map call (builtins.concatLists [[
			(bind_exec "SUPER + SUPER_L" "pkill rofi || rofi -show drun -modi drun,filebrowser,run,window")
		]]);
    };
}
