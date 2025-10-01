{ ... }:

{
    programs.waybar.settings.main = {
        "hyprland/workspaces" = {
            all-outputs = false;
            active-only = false;
            on-click = "activate";
            show-special = false;
            on-scroll-up = "hyprctl dispatch split-workspace -1";
            on-scroll-down = "hyprctl dispatch split-workspace +1";
            persistent-workspaces = { "*" = 1; };
            format = "{windows}";
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
                "class<[Ss]team>" = "";
            };
        };

        "custom/power" = {
            format = " ⏻ ";
            on-click = "wlogout -b 5";
            tooltip = true;
            tooltip-format = "Left Click = Logout Menu";
        };

        "custom/swaync" = {
            tooltip = true;
            tooltip-format = "Left Click: Launch Notification Center\nRight Click: Do not Disturb";
            format = "{icon} ";
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

        "temperature" = {
            interval = 10;
            tooltip = true;
            hwmon-path = [
                "/sys/class/hwmon/hwmon1/temp1_input"
                "/sys/class/thermal/thermal_zone0/temp"
            ];
            #thermal-zone = 0;
            critical-threshold = 82;
            format-critical = "{temperatureC}°C {icon}";
            format = "{temperatureC}°C {icon}";
            format-icons = [
                "󰈸"
            ];
            on-click-right = "../scripts/WaybarScripts.sh --nvtop";
        };

        "tray" = {
            icon-size = 20;
            spacing = 4;
        };

        "pulseaudio" = {
            format = "{icon} {volume}%";
            format-bluetooth = "{icon} 󰂰 {volume}%";
            format-muted = "󰖁";
            format-icons = {
                headphone = "";
                hands-free = "";
                headset = "";
                phone = "";
                portable = "";
                car = "";
                default = [
                    "" "" "󰕾" ""
                ];
                ignored-sinks = [
                    "Easy Effects Sink"
                ];
            };
            scroll-step = 5.0;
            on-click = "../scripts/Volume.sh --toggle";
            on-click-right = "pavucontrol -t 3";
            on-scroll-up = "../scripts/Volume.sh --inc";
            on-scroll-down = "../scripts/Volume.sh --dec";
            tooltip-format = "{icon} {desc} | {volume}%";
            smooth-scrolling-threshold = 1;
        };
    };
}