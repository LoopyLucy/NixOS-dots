{ pkgs, lib, ... }:

{
    #catpuccin.waybar = {
        #enable = true;
	#mode = "createLink";
    #};

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
                    "group/notify"
                ];

                #Modules
                "hyprland/workspaces" = {
                    all-outputs = true;
                    on-click = "activate";
                    show-special = false;
                    on-scroll-up = "hyprctl dispatch workspace e-1";
                    on-scroll-down = "hyprctl dispatch workspace e+1";
                    persistent-workspaces = { "*" = 1; };
                    format = "{windows} ";
                    format-icons = {
                        active = " :";
                        default = " :";
                    };
                    format-window-separator = " ";
                    window-rewrite-default = "";
                    window-rewrite = {
                        "class<kitty|konsole>" = "";

                        "class<.*zen.*>" = "󰰷";

                        "class<code|VSCode|code-url-handler|code-oss|codium|codium-url-handler|VSCodium>" = "";

                        "class<[Tt]hunderbird|[Tt]hunderbird-esr>" = "";

                        "class<[Dd]iscord|[Ww]ebcord|Vesktop>" = "";
                    };
                };
            };
        };
    };
}
