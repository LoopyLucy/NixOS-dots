{ pkgs, lib, ... }:

{
    imports = [
        ./modules.nix
    ];
    #catpuccin.waybar = {
        #enable = true;
	#mode = "createLink";
    #};

    services.swaync.enable = true;

    home.packages = with pkgs; [
        networkmanagerapplet
        blueman
    ];

    services.blueman-applet.enable = true;

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
                margin-top = 8;

                modules-left = [
                    "clock"
                    "custom/weather"
                    "temperature"
                    "cpu"
                ];

                modules-center = [
                    "hyprland/workspaces"
                ];

                modules-right = [
                    "tray"
                    "mpris"
                    "pulseaudio"
                    "battery"
                    "custom/power"
                    "custom/swaync"
                ];
            };
        };
    };
}
