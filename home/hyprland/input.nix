{ lib, ... }:

let
    inherit ( import ./lua_utils.nix { inherit lib; })
        luaify lambda call bind_flags bind bind_exec smw with_flags on_startup;
in {
    wayland.windowManager.hyprland.settings = {
        config.input = {
            kb_layout = "gb";
            numlock_by_default = true;

            kb_options = "caps:super";
        };

        bind = map call (builtins.concatLists [[
                    /* Software */
                    (bind_exec "SUPER + F" "thunar") /* Thunar */
                    (bind_exec "SUPER + T" "kitty") /* Kitty */
                    (bind_exec "SUPER + B" "zen-beta") /* Zen Browser */
                    #(bind_exec "Print" "grimblast copysave area --freeze ~/Pictures/Screenshots/$(date +%Y-%m-%d_%H-%M-%S).png") /* Screenshot */
                    #(bind "Print" (lambda ''
                    #    local h = io.popen('hyprctl activewindow | grep class:'):read('*a'):match('class:%s*(%S+)')
                    #    local app = (h and h ~= "") and h:lower() or "desktop"
                    #    local dir = os.getenv("HOME") .. "/Pictures/Screenshots/" .. app
                    #    os.execute("(mkdir -p " .. dir .. " && grimblast copysave area --freeze " .. dir .. "/" .. os.date("%Y-%m-%d_%H-%M-%S") .. ".png) &")
                    #''))
                    #(bind_exec "SHIFT + Print" "grimblast copysave active") /* Screenshot Active Window */
                    #(bind_exec "SUPER + Print" "grimblast copysave screen") /* Screenshot Fullscreen */

                    /* System */
                    (bind "CONTROL + ALT + delete" "hl.dsp.exit()") /* Exit Hyprland */
                    (bind_exec "SUPER + SHIFT + R" "pkill waybar || waybar") /* Toggle Waybar */


                    /* Window Control */
                    (bind "SUPER + Q" "hl.dsp.window.close()") /*Close Window*/
                    (bind "SUPER + SHIFT + F" "hl.dsp.window.fullscreen({ mode = 'maximized', action = 'toggle'})") /* Pseudo Fullscreen */
                    (bind "SUPER + ALT + F" "hl.dsp.window.fullscreen()") /* Fullscreen */
                    (bind "SUPER + SHIFT + SPACE" "hl.dsp.window.float()") /* Toggle Floating */
                    (bind "SUPER + O" "hl.dsp.window.set_prop({ prop = 'opaque', value = 'toggle'})") /* Toggle Opacity */

                    (bind "SUPER + SHIFT + D" (smw "move_to_workspace" "+1"))
                    (bind "SUPER + SHIFT + A" (smw "move_to_workspace" "-1"))
                    (bind "SUPER + SHIFT + right" (smw "move_to_workspace" "+1"))
                    (bind "SUPER + SHIFT + left" (smw "move_to_workspace" "-1"))
                    #(bind "SUPER + SHIFT + mouse_up" (smw "move_to_workspace" "-1"))
                    (bind_flags "SUPER + SHIFT + mouse_up" (smw "move_to_workspace" "-1") { mouse = true; })
                    #(bind "SUPER + SHIFT + mouse_down" (smw "move_to_workspace" "+1"))
                    (bind_flags "SUPER + SHIFT + mouse_down" (smw "move_to_workspace" "+1") { mouse = true; })
                    #(bind "SUPER + SHIFT + mouse_right" (smw "move_to_workspace" "+1"))
                    (bind_flags "SUPER + SHIFT + mouse_right" (smw "move_to_workspace" "+1") { mouse = true; })
                    #(bind "SUPER + SHIFT + mouse_left" (smw "move_to_workspace" "-1"))
                    (bind_flags "SUPER + SHIFT + mouse_left" (smw "move_to_workspace" "-1") { mouse = true; })

                    (bind "SUPER + D" (smw "cycle_workspaces" "+1"))
                    (bind "SUPER + A" (smw "cycle_workspaces" "-1"))
                    (bind "SUPER + right" (smw "cycle_workspaces" "+1"))
                    (bind "SUPER + left" (smw "cycle_workspaces" "-1"))
                    #(bind "SUPER + mouse_up" (smw "cycle_workspaces" "-1"))
                    (bind_flags "SUPER + mouse_up" (smw "cycle_workspaces" "-1") { mouse = true; non_consuming = true; })
                    #(bind "SUPER + mouse_down" (smw "cycle_workspaces" "+1"))
                    (bind_flags "SUPER + mouse_down" (smw "cycle_workspaces" "+1") { mouse = true; non_consuming = true;})
                    #(bind "SUPER + mouse_right" (smw "cycle_workspaces" "+1"))
                    (bind_flags "SUPER + mouse_right" (smw "cycle_workspaces" "+1") { mouse = true; non_consuming = true; })
                    #(bind "SUPER + mouse_left" (smw "cycle_workspaces" "-1"))
                    (bind_flags "SUPER + mouse_left" (smw "cycle_workspaces" "-1") { mouse = true; non_consuming = true; })

                    (bind "SUPER + ALT + D" (smw "change_monitor" " +1"))
                    (bind "SUPER + ALT + A" (smw "change_monitor" "-1"))
                    (bind "SUPER + ALT + right" (smw "change_monitor" "+1"))
                    (bind "SUPER + ALT + left" (smw "change_monitor" "-1"))
                    (bind "SUPER + ALT + mouse_up" (smw "change_monitor" "+1"))
                    (bind "SUPER + ALT + mouse_down" (smw "change_monitor" "-1"))
                    (bind "SUPER + ALT + mouse_right" (smw "change_monitor" "+1"))
                    (bind "SUPER + ALT + mouse_left" (smw "change_monitor" "-1"))

                    /* Background */
                    (bind_exec "SUPER + R" "bash ~/.config/hypr/scripts/RandBackground.sh")
                ]   
                (with_flags { mouse = true; } [
                    (bind "SUPER + mouse:272" "hl.dsp.window.drag()")
                    (bind "SUPER + mouse:273" "hl.dsp.window.resize()")
                ])

                (with_flags { locked = true; } [
                    (bind_exec "XF86AudioNext"  "playerctl next")
                    (bind_exec "XF86AudioPause" "playerctl play-pause")
                    (bind_exec "XF86AudioPlay"  "playerctl play-pause")
                    (bind_exec "XF86AudioPrev"  "playerctl previous")
                    (bind_exec "CTRL + ALT + right"  "playerctl next")
                    (bind_exec "CTRL + ALT + left"  "playerctl previous")
                    (bind_exec "CTRL + ALT + down" "playerctl play-pause")
                ])

                (with_flags { repeating = true; locked = true; } [
                    (bind_exec "XF86AudioRaiseVolume"  "wpctl set-volume -l 1 @DEFAULT_AUDIO_SINK@ 5%+")
                    (bind_exec "XF86AudioLowerVolume"  "wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-")
                    (bind_exec "XF86AudioMute"         "wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle")
                    (bind_exec "XF86AudioMicMute"      "wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle")
                ])

                (
                    # workspaces
                    # binds $mainMod + [shift +] {1..9} to [move to] workspace {1..9}
                    builtins.concatLists (builtins.genList (i:
                        let ws = i + 1;
                        in [
                            #"$mainMod, code:1${toString i}, split-workspace, ${toString ws}"
                            #"$mainMod SHIFT, code:1${toString i}, split-movetoworkspace, ${toString ws}"
                            (bind "SUPER + ${toString ws}" (smw "workspace" "${toString ws}"))
                            (bind "SUPER + SHIFT + ${toString ws}" (smw "move_to_workspace" "${toString ws}"))
                        ]
                    )9)
                )
            ]
        );
    };
}
