{ lib, pkgs, ... }:

{
    wayland.windowManager.hyprland.settings = {
        exec-once = [
            "systemctl --user start hyprpaper"
            "sleep 5; bash ~/.config/hypr/scripts/RandBackground.sh"
        ];
    };

    services.hyprpaper = {
        enable = true;
        
        settings = {
            splash = false;
        };
    };
}