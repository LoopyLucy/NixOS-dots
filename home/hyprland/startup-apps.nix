{ inputs, pkgs, fetchurl, lib, ... }:

{
    wayland.windowManager.hyprland.settings = {
        exec-once = [ 
            #System
            "waybar"
            "nm-applet"
            "${pkgs.wl-clipboard}/bin/wl-paste -p --watch ${pkgs.wl-clipboard}/bin/wl-copy -pc"
            "xrandr --output <DP-2> --primary"
    
            #Software
            "vesktop"
        ];
        windowrule = [
            "monitor 0, match:class ^(vesktop)$"
        ];
    };
}