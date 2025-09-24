{ inputs, pkgs, fetchurl, lib, ... }:

{
    wayland.windowManager.hyprland = {
        settings = {

            input = {
                kb_layout = "gb";
                numlock_by_default = true;

                kb_options = caps:super;
            };

            "$mainMod" = "SUPER";

            bindm = [
                "$mainMod, mouse:272, movewindow" # NOTE: mouse:272 = left click
                "$mainMod, mouse:273, resizewindow" # NOTE: mouse:273 = right click
            ];

            bind = [
                #USER (Software)
                "$mainMod, F, exec, dolphin"            
                "$mainMod, B, exec, zen"
                "$mainMod, T, exec, kitty"
                "$mainMod, K, exec, konsole"
                ",         Print, exec, grimblast copy area"
                
                #System
                "CTRL ALT, Delete, exec, hyprctl dispatch exit 0"
                
                # Window Control
                "$mainMod,       Q, killactive,"
                "$mainMod SHIFT, F, fullscreen, 1"
                "$mainMod SHIFT, SPACE, togglefloating"
                "$mainMod SHIFT, D, movetoworkspace, +1"
                "$mainMod SHIFT, A, movetoworkspace, -1"
                "$mainMod SHIFT, left, movetoworkspace, +1"
                "$mainMod SHIFT, right, movetoworkspace, -1"
                "$mainMod SHIFT, mouse_up, movetoworkspace, +1"
                "$mainMod SHIFT, mouse_down, movetoworkspace, -1"
                
                # Workspaces
                "$mainMod, right, workspace, +1"
                "$mainMod, left, workspace, -1"
                "$mainMod, D, workspace, +1"
                "$mainMod, A, workspace, -1"
                "$mainMod, mouse_up, workspace, +1"
                "$mainMod, mouse_down, workspace, -1"
                "$mainMod, mouse_left, workspace, +1"
                "$mainMod, mouse_right, workspace, -1"
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