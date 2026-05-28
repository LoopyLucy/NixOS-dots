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
                background = "#000000";
                accent = "#cba6f7";
                # Add other supported theme properties here
            };
        };
    };

    wayland.windowManager.hyprland.settings = {
		window_rule = [
			{ match.class = "^[Vv]icinae$"; stay_focused = true; rounding = 0; }
		];
		bind = map call (builtins.concatLists [[
			(bind_exec "SUPER + SUPER_L" "xdg-open vicinae://toggle")
		]]);
    };
}
