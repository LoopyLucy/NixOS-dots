{ pkgs, lib, ... }:

{
    #catpuccin.waybar = {
        #enable = true;
	#mode = "createLink";
    #};

    wayland.windowManager.hyprland.settings.exec-once = [ "waybar" ];

    programs.waybar = {
        enable = true;
        style = ./style.css;

        settings = {
            main = {
                layer = "top";
                position = "top";
                width = 1070;
                margin-left = 200;
                margin-right = 200;
                margin-top = 4;

                modules-left = [
                    "clock"
                    "custom/weather"
                    "temperature"
                    "cpu"
                ];

                modules-center = [
                    "hyprland/workspaces#rw"
                ];

                modules-right = [
                    "tray"
                    "mpris"
                    "pulseaudio"
                    "battery"
                    "custom/power"
                    "group/notify"
                ];
            };
        };
    };
}
