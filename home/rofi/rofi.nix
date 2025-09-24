{ config, ... }:

let
    inherit (config.lib.formats.rasi) mkLiteral;
in {
    programs.rofi = {
    	enable = true;
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
