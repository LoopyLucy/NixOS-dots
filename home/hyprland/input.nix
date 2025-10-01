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

            bind = [
                # USER (Software)
                "$mainMod, F,                exec, thunar"            
                "$mainMod, B,                exec, zen"
                "$mainMod, T,                exec, kitty"
                "$mainMod, K,                exec, konsole"
                ",         Print,            exec, grimblast copy area"
                
                # System
                "CTRL ALT, Delete,           exec, hyprctl dispatch exit 0"
                "$mainMod SHIFT, R,          exec, pkill waybar || waybar"
                
                # Window Control
                "$mainMod,       Q,          killactive,"
                "$mainMod SHIFT, F,          fullscreen, 1"
                "$mainMod SHIFT, SPACE,      togglefloating"
                "$mainMod SHIFT, D,          split-movetoworkspace, +1"
                "$mainMod SHIFT, A,          split-movetoworkspace, -1"
                "$mainMod SHIFT, left,       split-movetoworkspace, +1"
                "$mainMod SHIFT, right,      split-movetoworkspace, -1"
                "$mainMod SHIFT, mouse_up,   split-movetoworkspace, +1"
                "$mainMod SHIFT, mouse_down, split-movetoworkspace, -1"
                
                # Workspaces
                "$mainMod, right,            split-workspace, +1"
                "$mainMod, left,             split-workspace, -1"
                "$mainMod, D,                split-workspace, +1"
                "$mainMod, A,                split-workspace, -1"
                "$mainMod, mouse_up,         split-workspace, +1"
                "$mainMod, mouse_down,       split-workspace, -1"
                "$mainMod, mouse_left,       split-workspace, +1"
                "$mainMod, mouse_right,      split-workspace, -1"
            ]
            ++ (
                # workspaces
                # binds $mainMod + [shift +] {1..9} to [move to] workspace {1..9}
                builtins.concatLists (builtins.genList (i:
                    let ws = i + 1;
                    in [
                        "$mainMod, code:1${toString i}, split-workspace, ${toString ws}"
                        "$mainMod SHIFT, code:1${toString i}, split-movetoworkspace, ${toString ws}"
                    ]
                )9)

            );

            bindm = [
                "$mainMod, mouse:272, movewindow" # NOTE: mouse:272 = left click
                "$mainMod, mouse:273, resizewindow" # NOTE: mouse:273 = right click
            ];

            bindel = [
                ",XF86AudioRaiseVolume, exec, wpctl set-volume -l 1 @DEFAULT_AUDIO_SINK@ 5%+"
                ",XF86AudioLowerVolume, exec, wpctl set-volume -l 1 @DEFAULT_AUDIO_SINK@ 5%-"
                ",       XF86AudioMute, exec, wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"
            ];

            bindl = [
                ", XF86AudioPlay, exec, playerctl play-pause"
                ",XF86AudioPause, exec, playerctl play-pause"
                ", XF86AudioNext, exec, playerctl next"
                ", XF86AudioPrev, exec, playerctl previous"
            ];
        };
    };
}