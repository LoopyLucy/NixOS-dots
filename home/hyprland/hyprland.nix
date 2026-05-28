{ inputs, pkgs, fetchurl, lib, config, ... }:

let
    inherit (import ./lua_utils.nix { inherit lib; }) 
        luaify lambda call bind_flags bind bind_exec with_flags on_startup;
in {
    imports = [
        ./startup-apps.nix
        ./input.nix
        ./hyprpaper.nix
	    ../waybar/waybar.nix
	    ../rofi/rofi.nix
        ../wlogout/wlogout.nix
        ../screenshot/screenshot.nix
    ];

    xdg.configFile."hypr/scripts".source = ./scripts;

    home.packages = with pkgs; [
        hyprpicker
        wl-clipboard
        hyprsome
        pavucontrol
        rustdesk-flutter
        playerctl
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

        configType = "lua";
        settings = {
            config = {
                general = {
                    border_size = 0;
                    gaps_in = 4;
                    gaps_out = 4;
                };

                xwayland.force_zero_scaling = true;
                
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
                    disable_splash_rendering = true;
                    background_color = "rgb(000000)";
                    middle_click_paste = true; # required or electron will emulate it.
                    enable_anr_dialog = false;
                };
            };

            monitor = [
                { output = "DP-1"; mode = "preferred"; position = "auto-left"; scale = 1; }
                { output = "DP-2"; mode = "preferred"; position = "0x0"; scale = 1; }
                { output = "HDMI-A-1"; mode = "preferred"; position = "auto-right"; scale = 1; }
            ];

            window_rule = [
                /* Tags */
                { match.class = "^([Hh]ytale[Cc]lient|org-prismlauncher-EntryPoint|.*[Mm]inecraft.*)"; tag = "+games"; }
                { match.class = "^(vlc|com.stremio.stremio)"; tag = "+media"; }

                /* Overrides */
                { match = { tag = "games*"; class = "^(.*zen.*)"; }; opaque = true; fullscreen_state = 2; }
                { match = { tag = "media*"; }; opacity = "1.0 override"; fullscreen = true; }

                /* Force Floating */
                { match = { class = "^([Tt]hunar)"; title = "negative:(.*[Tt]hunar.*)"; }; float = true;}

                /* Centering */
                { match.title = "^(Picture-in-Picture)$"; float = true; }
            ];
        };
    };
}
