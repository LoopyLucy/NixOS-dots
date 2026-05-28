{ config, lib, ... }:

let
	inherit (import ../hyprland/lua_utils.nix { inherit lib; })
        luaify lambda call bind_flags bind bind_exec with_flags on_startup;
    inherit (config.lib.formats.rasi) mkLiteral;
in {
	xdg.configFile."rofi/colours.rasi".source = ./colours.rasi;
	xdg.configFile."rofi/style.rasi".source = ./style.rasi;

    programs.rofi = {
    	enable = true;
		font = "JetBrainsMono Nerd Font SemiBold 11";
		theme = "~/.config/rofi/style.rasi";
    };

    wayland.windowManager.hyprland.settings = {
		window_rule = [
			{ match.class = "^Rofi$"; stay_focused = true; rounding = 0; }
		];
		bind = map call (builtins.concatLists [[
			(bind_exec "SUPER + SPACE" "pkill rofi || rofi -show drun -modi drun,filebrowser,run,window")
		]]);
    };
}