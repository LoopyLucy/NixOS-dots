{ lib, ... }:

let
    inherit ( import ./lua_utils.nix { inherit lib; })
        luaify lambda call bind_flags bind bind_exec with_flags on_startup;
in {
    wayland.windowManager.hyprland.settings = {
        input = {
            kb_layout = "gb";
            numlock_by_default = true;

            kb_options = caps:super;
        };

        bind = map call (builtins.concatLists [[
                    /* Software */
                    (bind_exec "SUPER + F" "thunar") /* Thunar */
                    (bind_exec "SUPER + T" "kitty") /* Kitty */
                    (bind_exec "SUPER + B" "zen-beta") /* Zen Browser */
                    (bind_exec "Print" "grimblast copy area") /* Screenshot */

                    /* System */
                    (bind "CONTROL + ALT + delete" "hl.dsp.exit()") /* Exit Hyprland */
                    (bind_exec "SUPER + SHIFT + R" "pkill waybar || waybar") /* Toggle Waybar */


                    /* Window Control */
                    (bind "SUPER + Q" "hl.dsp.window.close()") /*Close Window*/
                    (bind "SUPER + SHIFT + F" "hl.dsp.window.maximise()") /* Pseudo Fullscreen */
                    (bind "SUPER + ALT + F" "hl.dsp.window.fullscreen()") /* Fullscreen */
                    (bind_exec "SUPER" "") /*  */

                    /* Background */
                    (bind_exec "SUPER + SHIFT + R" "bash ~/.config/hypr/scripts/RandBackground.sh")
                ]   
            ]
        );
    };
    /* wayland.windowManager.hyprland = {
        settings = {

            "$mainMod" = "SUPER";

            bind = [
                # USER (Software)
                "$mainMod, F,                     exec, thunar"            
                "$mainMod, B,                     exec, zen-beta"
                "$mainMod, T,                     exec, kitty"
                "$mainMod, K,                     exec, konsole"
                ",         Print,                 exec, grimblast copy area"
                     
                # System     
                "CTRL ALT, Delete,                exec, hyprctl dispatch exit 0"
                "$mainMod SHIFT, R,               exec, pkill waybar || waybar"

                # Background
                "$mainMod, R,                     exec, bash ~/.config/hypr/scripts/RandBackground.sh"
                     
                # Window Control     
                "$mainMod,       Q,               killactive,"
                "$mainMod SHIFT, F,               fullscreen, 1"
                "$mainMod ALT,   F,                fullscreen"
                "$mainMod SHIFT, SPACE,           togglefloating"
                "$mainMod,       O,               setprop, active opaque toggle"
                "$mainMod SHIFT, D,               split-movetoworkspace, +1"
                "$mainMod SHIFT, A,               split-movetoworkspace, -1"
                "$mainMod SHIFT, left,            split-movetoworkspace, +1"
                "$mainMod SHIFT, right,           split-movetoworkspace, -1"
                "$mainMod SHIFT, mouse_up,        split-movetoworkspace, +1"
                "$mainMod SHIFT, mouse_down,      split-movetoworkspace, -1"
                "$mainMod SHIFT, mouse_right,     split-movetoworkspace, +1"
                "$mainMod SHIFT, mouse_left,      split-movetoworkspace, -1"
                     
                # Workspaces     
                "$mainMod, right,                 split-workspace, +1"
                "$mainMod, left,                  split-workspace, -1"
                "$mainMod, D,                     split-workspace, +1"
                "$mainMod, A,                     split-workspace, -1"
                "$mainMod, mouse_up,              split-workspace, +1"
                "$mainMod, mouse_down,            split-workspace, -1"
                "$mainMod, mouse_right,           split-workspace, +1"
                "$mainMod, mouse_left,            split-workspace, -1"
     
                # Monitors     
                "$mainMod ALT, right,             split-changemonitor, next"
                "$mainMod ALT, left,              split-changemonitor, prev"
                "$mainMod ALT, D,                 split-changemonitor, next"
                "$mainMod ALT, A,                 split-changemonitor, prev"
                "$mainMod ALT, mouse_up,          split-changemonitor, next"
                "$mainMod ALT, mouse_down,        split-changemonitor, prev"
                "$mainMod ALT, mouse_right,       split-changemonitor, next"
                "$mainMod ALT, mouse_left,        split-changemonitor, prev"
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
    }; */
}