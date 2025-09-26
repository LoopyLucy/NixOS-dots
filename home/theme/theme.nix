{ pkgs, ... }:

{
    gtk = {
        enable = true;
        theme = {
            name = "Breeze-Dark";
            package = pkgs.kdePackages.breeze-gtk;
        };
        gtk3.extraCss = (builtins.readFile ./colours.css);
        gtk4.extraCss = (builtins.readFile ./colours.css);
    };

    qt = {
        enable = true;
        platformTheme.name = "kvantum";
        style.name = "kvantum";
    };
}