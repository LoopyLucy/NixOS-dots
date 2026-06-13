{ inputs, pkgs, fetchurl, lib, ... }:

let
    inherit (import ./lua_utils.nix { inherit lib; })
        on_startup;
in {
    wayland.windowManager.hyprland.settings = {
        on = on_startup ''
            hl.exec_cmd("waybar")
            hl.exec_cmd("nm-applet")
            hl.exec_cmd("${pkgs.wl-clipboard}/bin/wl-paste -p --watch ${pkgs.wl-clipboard}/bin/wl-copy -pc")
            hl.exec_cmd("xrandr --output <DP-2> --primary")
            hl.exec_cmd("hyprctl setcursor Bibata-Modern-Classic 24")
            hl.exec_cmd("vicinae server")
            hl.exec_cmd("vesktop --enable-features=UseOzonePlatform --ozone-platform=wayland --enable-features=vaapi")
        '';
        window_rule = [
            { match.class = "^(vesktop)$"; monitor = "DP-1"; }
        ];
    };
}