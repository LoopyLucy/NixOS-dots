{ pkgs, lib, ... }:

{
    #catpuccin.waybar = {
        #enable = true;
	#mode = "createLink";
    #};

    wayland.windowManager.hyprland.settings.exec-once = [
	"waybar"
    ];

    programs.waybar = {
	enable = true;
	style = ./style.css;
    };
}
