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

    xdg.configFile."waybar/inverse-corner-left.svg".source = ./inverse-corner-left.svg;
    xdg.configFile."waybar/inverse-corner-right.svg".source = ./inverse-corner-right.svg;

    #services.blueman-applet.enable = true;

    programs.waybar = {
        enable = true;
        style = ./style.css;

    #    settings = {
    #        main = {
    #            layer = "top";
    #            position = "top";
    #            width = 1070;
    #            margin-left = 200;
    #            margin-right = 200;
    #            margin-top = 8;
    #
    #            modules-left = [
    #                "clock"
    #                "custom/weather"
    #                "temperature"
    #                "cpu"
    #            ];
    #
    #            modules-center = [
    #                "hyprland/workspaces"
    #            ];
    #
    #            modules-right = [
    #                "tray"
    #                "mpris"
    #                "pulseaudio"
    #                "battery"
    #                "custom/power"
    #                "custom/swaync"
    #            ];
    #        };
    #    };

        settings = {
            main = {
                layer = "top";
                position = "top";
                width = 1070;
                height = 35;
                margin-top = 0;

                "group/left" = {
                    orientation = "inherit";
                    modules = [
                        "clock"
                        "custom/weather"
                        "temperature"
                        "cpu"
                    ];
                };

                "group/center" = {
                    orientation = "inherit";
                    modules = [
                        "hyprland/workspaces"
                    ];
                };

                "group/right" = {
                    orientation = "inherit";
                    modules = [
                        "tray"
                        "mpris"
                        "pulseaudio"
                        "battery"
                        "custom/power"
                        "custom/swaync"
                    ];
                };

                modules-center = [
                    "custom/side_left"
                    "group/left"
                    "custom/spacer"
                    "group/center"
                    "custom/spacer"
                    "group/right"
                    "custom/side_right"
                ];
            };
        };
    };
}
