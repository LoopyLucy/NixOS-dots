{ inputs, pkgs, fetchurl, lib, ... }:

{
    imports = [
        ./startup-apps.nix
        ./input.nix
        ./hyprpaper.nix
	    ../waybar/waybar.nix
	    ../rofi/rofi.nix
        ../wlogout/wlogout.nix
    ];

    xdg.configFile."hypr/scripts".source = ./scripts;

    home.packages = with pkgs; [
        hyprpicker
        grimblast
        wl-clipboard
        hyprsome
        pavucontrol
    ];

    wayland.windowManager.hyprland = {
        enable = true;
        xwayland.enable = true;

        package = inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.hyprland;
        portalPackage = inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.xdg-desktop-portal-hyprland;

        systemd.variables = ["--all"];

        plugins = [
            inputs.split-monitor-workspaces.packages.${pkgs.stdenv.hostPlatform.system}.split-monitor-workspaces
        ];

        settings = {

            monitor = [
                "DP-1,     preferred, auto, 1"
                "DP-2,     preferred, auto, 1"
                "HDMI-A-1, preferred, auto, 1"
            ];

            xwayland.force_zero_scaling = true;

            general = {
                border_size = 0;
                gaps_in = 4;
                gaps_out = 4;
            };

            decoration = {
                rounding = 10;

                active_opacity = 0.9;
                inactive_opacity = 0.8;
                fullscreen_opacity = 1.0;

                dim_inactive = true;
                dim_strength = 0.1;
                dim_special = 0.8;

                shadow = {
                    enabled = false;
                };

                blur = {
                    enabled = true;
                    size = 6;
                    passes = 2;
                    ignore_opacity = true;
                    new_optimizations = true;
                    special = true;
                    popups = true;
                };
            };

            misc = {
                disable_hyprland_logo = true;
                background_color = "rgb(000000)";
                middle_click_paste = true; # required or electron will emulate it.
                enable_anr_dialog = false;
            };

        };

    };

}
