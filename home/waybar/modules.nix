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
                active = " ";
                default = " ";
                empty = "";
            };
            format-window-separator = "";
            window-rewrite-default = " ";
            window-rewrite = {
                "class<kitty|konsole>" = " ";
                "class<.*zen.*>" = "󰰷 ";
                "class<code|VSCode|code-url-handler|code-oss|codium|codium-url-handler|VSCodium>" = " ";
                "class<[Tt]hunderbird|[Tt]hunderbird-esr>" = " ";
                "class<[Dd]iscord|[Ww]ebcord|Vesktop>" = " ";
                "class<[Ss]team>" = " ";
            };
        };

        "custom/side_left" = {
            format = "  ";
        };

        "custom/spacer" = {
            format = "      ";
        };

        "custom/side_right" = {
            format = "  ";
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

        "clock" = {
            interval = 1;
            format = " {:%H:%M}";
            #format-alt = " {:%H:%M  %Y, %d %B, %A}";
            format-alt = " {:%H:%M  %A, %d %B, %Y}";
            tooltip-format = "<tt><small>{calendar}</small></tt>";
            calendar = {
                mode = "year";
                mode-mon-col = 3;
                week-pos = "right";
                on-scroll = 1;
                format = {
                    months = "<span color='#ffead3'><b>{}</b></span>";
                    days = "<span color='#ecc6d9'><b>{}</b></span>";
                    weeks = "<span color='#99ffdd'><b>W{:%V}</b></span>";
                    weekdays = "<span color='#ffcc66'><b>{}</b></span>";
                    today = "<span color='#ff6699'><b><u>{}</u></b></span>";
                };
            };
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
            on-click = "wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle";
            on-click-right = "pavucontrol -t 3";
            on-scroll-up = "wpctl set-mute @DEFAULT_AUDIO_SINK@ 0 && wpctl set-volume -l 1.4 @DEFAULT_AUDIO_SINK@ 5%+";
            on-scroll-down = "wpctl set-mute @DEFAULT_AUDIO_SINK@ 0 && wpctl set-volume -l 1.4 @DEFAULT_AUDIO_SINK@ 5%-";
            tooltip-format = "{icon} {desc} | {volume}%";
            smooth-scrolling-threshold = 1;
        };

        "mpris" = {
            format = "{player_icon} {dynamic}";
            format-paused = "{status_icon}";
            player-icons = {
                default = "▶";
                mpv = "🎵";
            };
            status-icons = {
                paused = "⏸";
            };
            title-len = 8;
            album-len = 0;
            artist-len = 0;
        };
    };
}