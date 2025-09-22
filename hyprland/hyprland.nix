{ inputs, pkgs, fetchurl, lib, ... }:

{
    imports = [


    ];

    home.packages = with pkgs; [
        hyprpicker
        networkmanagerapplet
        grimblast
    ];

    wayland.windowManager.hyprland = {
        enable = true;

        settings = {

            "$mainMod" = "SUPER";

            bind = [
                "$mainMod, B, exec, zem"
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

            monitor = [",preferred,auto,1.0"];

        };

    };

}
