{ pkgs, ... }:

{
    gtk = {
        enable = true;
        theme = {
            name = "Breeze-Dark";
            package = pkgs.kdePackages.breeze-gtk;
        };
        gtk3.extraCss = (builtins.readFile ./colors.css);
        gtk4.extraCss = (builtins.readFile ./colors.css);
    };

    qt = {
        enable = true;
        platformTheme.name = "kvantum";
        style.name = "kvantum";
    };
}