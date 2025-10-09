{ lib, pkgs, ... }:

{
    wayland.windowManager.hyprland.settings = {
        exec-once = [
            "systemctl --user start hyprpaper"
            "bash ~/.config/hypr/scripts/RandBackground.sh"
        ];
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