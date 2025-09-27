{ pkgs, ... }:

{
    gtk = {
        enable = true;
        theme = {
            name = "Breeze-Dark";
            package = pkgs.kdePackages.breeze-gtk;
            #name = "orchis-theme"; # Or another dark theme
            #package = pkgs.orchis-theme;
        };
        gtk3.extraCss = (builtins.readFile ./colours.css);
        gtk4.extraCss = (builtins.readFile ./colours.css);
    };

    dconf.settings."org/gnome/desktop/interface".color-scheme = "prefer-dark";

    qt = {
        enable = true;
        platformTheme.name = "kvantum";
        style.name = "kvantum";
    };
}