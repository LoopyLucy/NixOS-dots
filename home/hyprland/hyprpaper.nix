{ lib, ... }:

let
    wallpaper = toString /home/erin/Pictures/Backgrounds/Needle_Night_Leda.png;
in {

    services.hyprpaper = {
        enable = true;
    };

    wayland.windowManager.hyprland.settings = {
        exec-once = [
            "systemctl --user start hyprpaper"
            "../scripts/RandBackground.sh"
        ];
    };

}