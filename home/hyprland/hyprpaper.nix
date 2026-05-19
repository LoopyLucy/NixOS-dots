{ lib, pkgs, ... }:

let
    inherit (import ./lua_utils.nix { inherit lib; })
        on_startup;
in {
    wayland.windowManager.hyprland.settings = {
        on = on_startup ''hl.exec_cmd("systemctl --user start hyprpaper; sleep 5; bash ~/.config/hypr/scripts/RandBackground.sh")'';
    };

    services.hyprpaper = {
        enable = true;
        
        settings = {
            splash = false;
        };
    };
}