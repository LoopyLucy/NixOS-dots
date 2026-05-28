{ config, lib, ... }:

let
	inherit (import ../hyprland/lua_utils.nix { inherit lib; })
        luaify lambda call bind_flags bind bind_exec with_flags on_startup;
    inherit (config.lib.formats.rasi) mkLiteral;
in {
    programs.vicinae = {
        enable = true;
        # Manage themes declaratively
        themes = {
            "my-custom-theme" = {
                meta = {
                    version = 1;
                    name = "Custom theme";
                    description = "My Theme";
                    variant = "dark";
                    inherits = "vicinae-dark";
                };
                background = "#111111";
                accent = "#cba6f7";
                colors = {
                    core = {
                        background = "#000000";
                        foreground = "#ffffff";
                    };
                };
            };
        };
    };

    wayland.windowManager.hyprland.settings = {
		window_rule = [
			{ match.class = "^[Vv]icinae$"; stay_focused = true; rounding = 10; }
		];

		bind = map call (builtins.concatLists [[
			(bind_exec "SUPER + SUPER_L" "xdg-open vicinae://toggle")
		]]);
    };
}