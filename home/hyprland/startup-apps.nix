{ inputs, pkgs, fetchurl, lib, ... }:

{
    wayland.windowManager.hyprland.settings.exec-once = [ 
        "waybar"
        "nm-applet"
    ];
}