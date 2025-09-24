{ inputs, pkgs, fetchurl, lib, ... }:

{
    imports = [
        ./startup-apps.nix
	    ../rofi/rofi.nix
	    ../waybar/waybar.nix
    ];

    home.packages = with pkgs; [
        hyprpicker
        networkmanagerapplet
        grimblast
    ];

    wayland.windowManager.hyprland = {
        enable = true;
        xwayland.enable = true;

        package = inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.hyprland;
        portalPackage = inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.xdg-desktop-portal-hyprland;

        systemd.variables = ["--all"];

        settings = {

            monitor = [",preferred,auto,1.0"];

            xwayland.force_zero_scaling = true;

            input = {
                kb_layout = "gb";
                numlock_by_default = true;

                kb_options = caps:super;
            };

            general = {
                border_size = 0;
                gaps_in = 4;
                gaps_out = 4;
            };

            decoration = {
                rounding = 10;

                active_opacity = 1.0;
                inactive_opacity = 0.9;
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

            "$mainMod" = "SUPER";

            bindm = [
                "$mainMod, mouse:272, movewindow" # NOTE: mouse:272 = left click
                "$mainMod, mouse:273, resizewindow" # NOTE: mouse:273 = right click
            ];

            bind = [
                "CTRL ALT, Delete, exec, hyprctl dispatch exit 0"
                
                # Window Control
                "$mainMod, Q, killactive,"
                "$mainMod SHIFT, F, fullscreen, 1"
                "$mainMod, SPACE, togglefloating"

		        "$mainMod, F, exec, dolphin"
                "$mainMod, B, exec, zen"
                "$mainMod, T, exec, kitty"
                "$mainMod, K, exec, konsole"
                ", Print, exec, grimblast copy area"

                # Workspaces
                "$mainMod, right, workspace, m+1"
                "$mainMod, left, workspace, m-1"
                "$mainMod, mouse_down, workspace, e-1"
                "$mainMod, mouse_up, workspace, e+1"
                "$mainMod, mouse_right, workspace, e-1"
                "$mainMod, mouse_left, workspace, e+1"
            ]
            ++ (
                # workspaces
                # binds $mainMod + [shift +] {1..9} to [move to] workspace {1..9}
                builtins.concatLists (builtins.genList (i:
                    let ws = i + 1;
                    in [
                        "$mainMod, code:1${toString i}, workspace, ${toString ws}"
                        "$mainMod SHIFT, code:1${toString i}, movetoworkspace, ${toString ws}"
                    ]
                )9)

            );

        };

    };

}
