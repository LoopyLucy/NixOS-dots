{ inputs, pkgs, fetchurl, lib, ... }:

{
    imports = [
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

        systemd.variables = ["--all"];

        settings = {

            monitor = [",preferred,auto,1.0"];

            input = {
                kb_layout = "gb";
                numlock_by_default = true;
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

		#xwayland.force_zero_scaling = true;
            };

            "$mainMod" = "SUPER";

            bind = [
                "$mainMod, Q, killactive,"

		        "$mainMod, F, exec, dolphin"
                "$mainMod, B, exec, zen"
                "$mainMod, T, exec, kitty"
                "$mainMod, K, exec, konsole"
                ", Print, exec, grimblast copy area"

                "CTRL ALT, Delete, exec, hyprctl dispatch exit 0"
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
