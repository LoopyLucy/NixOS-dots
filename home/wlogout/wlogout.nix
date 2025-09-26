{ config, pkgs, lib, ... }:

{

    xdg.configFile."wlogout/icons".source = ./icons;
    
    programs.wlogout = {
        enable = true;

        style = ./style.css;

        layout = [
            { label = "lock"; action = "systemctl poweroff"; text = "Lock"; keybind = "l"; }
            { label = "shutdown"; action = "systemctl poweroff"; text = "Shutdown"; keybind = "s"; }
            { label = "suspend"; action = "systemctl suspend"; text = "Suspend"; keybind = "e"; }
            { label = "reboot"; action = "systemctl reboot"; text = "Reboot"; keybind = "r"; }
            { label = "logout"; action = ""; text = "Logout"; keybind = "e"; }
        ];
    };
}