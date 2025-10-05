{ lib, pkgs, ... }:

{
    wayland.windowManager.hyprland.settings = {
        exec-once = [
            "systemctl --user start hyprpaper"
        ];
    };

    systemd.user.timers = {
        random-background = {
            
            #timerConfig = {
            #    OnCalendar = "*-*-* *:0/00:01";
            #    Persistent = true;
            #};
            #serviceConfig.ExecStart = "${pkgs.bash}/bin/bash ~/.config/hypr/scripts/RandBackground.sh";
        };
    };

    services.hyprpaper = {
        enable = true;
        settings = {
            ipc = "on";
            splash = false;
            splash_offset = 2.0;
            #preload = wallpaper;
            #wallpaper = " , ${wallpaper}";
        };
    };
}