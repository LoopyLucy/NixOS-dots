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
        rustdesk-flutter
        pixelorama
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
                "DP-1,     preferred, auto-left, 1"
                "DP-2,     preferred, 0x0, 1"
                "HDMI-A-1, preferred, auto-right, 1"
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

            windowrule = [
                #"center 1, match:float 1" #This was an extremely bad idea!

                #Tags
                "tag +games, match:class ^([Hh]ytale[Cc]lient|org-prismlauncher-EntryPoint|.*Minecraft.*)"
                "tag +media, match:class ^(vlc|com.stremio.stremio)"

                #Overrides
                "opacity 1.0 override, match:tag games*"
                "opacity 1.0 override, match:tag media*"
                "opacity 1.0 override, match:class ^(zen-beta)"

                #Monitors
                "monitor 1, match:tag games*"

                #Tiled
                "tile 1, match:tag games*"

                #Fullscreen
                "fullscreen 1, match:tag games*"

                # Steam
                "tile 1,  match:initial_class ^([Ss]team)$"
                "float 1, match:initial_class ^([Ss]team)$, match:title ^(Steam - Self Updater|Steam Settings|Friends List|menu)$"
                "center 1, match:initial_class ^([Ss]team)$, match:title ^(Steam - Self Updater|Steam Settings|Friends List)$"
                "max_size 600 1080, match:initial_class ^([Ss]team)$, match:title ^(Friends List)$"

                # Floating
                "float 1, match:class ([Tt]hunar), match:title negative:(.*[Tt]hunar.*)"
                "center 1, match:class ([Tt]hunar), match:title negative:(.*[Tt]hunar.*)"
                "float 1, match:title ^(Picture-in-Picture)$"
            ];

        };

    };

}
