{ config, ... }:

let
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
		windowrule = [
			"stayfocused, class:^Rofi$"
		];
		bindr = [
			"$mainMod, $mainMod_L, exec, pkill rofi || rofi -show drun -modi drun,filebrowser,run,window" #single tap $mainMod key open rofi
		];
    };

}