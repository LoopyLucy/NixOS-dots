{ inputs, pkgs, fetchurl, lib, ... }:

{
    wayland.windowManager.hyprland.settings.exec-once = [ 
        "waybar"
        "nm-applet"
        "${pkgs.wl-clipboard}/bin/wl-paste -p --watch ${pkgs.wl-clipboard}/bin/wl-copy -pc"
    ];
}