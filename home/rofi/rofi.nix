{ config, ... }:

let
    inherit (config.lib.formats.rasi) mkLiteral;
in {

	#xdg.configFile."rofi/colours.rasi".source = ./;

    programs.rofi = {
    	enable = true;

		theme = {
			"@theme" = ./style.rasi;
		};
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
