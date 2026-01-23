{ lib, pkgs, ... }:

let
    /*wallpaper = toString "~/Pictures/Backgrounds/Background3.PNG";*/
in {
    wayland.windowManager.hyprland.settings = {
        exec-once = [
            "systemctl --user start hyprpaper"
            "sleep 1; bash ~/.config/hypr/scripts/RandBackground.sh"
        ];
    };

    services.hyprpaper = {
        enable = true;
        
        settings = {
            splash = false;
            /*preload = wallpaper;
            wallpaper = " , ${wallpaper}";*/
        };
    };
}