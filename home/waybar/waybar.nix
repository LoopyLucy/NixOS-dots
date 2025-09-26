{ pkgs, lib, ... }:

{
    #catpuccin.waybar = {
        #enable = true;
	#mode = "createLink";
    #};

    services.swaync.enable = true;

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

                "custom/swaync" = {
                    tooltip = true;
                    tooltip-format = "Left Click: Launch Notification Center\nRight Click: Do not Disturb";
                    format = "{} {icon} ";
                    format-icons = {
                        notification = "<span foreground='red'><sup></sup></span>";
                        none = "";
                        dnd-notification = "<span foreground='red'><sup></sup></span>";
                        dnd-none = "";
                        inhibited-notification = "<span foreground='red'><sup></sup></span>";
                        inhibited-none = "";
                        dnd-inhibited-notification = "<span foreground='red'><sup></sup></span>";
                        dnd-inhibited-none = "";
	                };
                    return-type = "json";
                    exec-if = "which swaync-client";
                    exec = "swaync-client -swb";
                    on-click = "sleep 0.1 && swaync-client -t -sw";
                    on-click-right = "swaync-client -d -sw";
                    escape = true;
                };

                "group/notify" = {
                    orientation = "inherit";
                    drawer = {
                        transition-duration = 500;
                        children-class = "custom/swaync";
                        transition-left-to-right = false;
                    };
                    modules = "custom/swaync";
                };
            };
        };
    };
}
