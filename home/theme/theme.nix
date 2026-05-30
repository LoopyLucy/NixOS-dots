{ pkgs, ... }:

{
    # 1. Install the assets into your user profile
    home.packages = with pkgs; [
        papirus-icon-theme
        bibata-cursors
    ];

    gtk = {
        enable = true;
        theme = {
            name = "Breeze-Dark";
            package = pkgs.kdePackages.breeze-gtk;
            #name = "orchis-theme"; # Or another dark theme
            #package = pkgs.orchis-theme;
        };

        # 2. Force Thunar and other GTK apps to use Papirus icons instead of the ugly defaults
        iconTheme = {
            name = "Papirus-Dark";
            package = pkgs.papirus-icon-theme;
        };

        gtk3.extraCss = (builtins.readFile ./colours.css);
        gtk4.extraCss = (builtins.readFile ./colours.css);
    };

    # 3. Handle the cursor layout gracefully across Wayland, X11, and GTK backends
    home.pointerCursor = {
        gtk.enable = true;
        x11.enable = true;
        package = pkgs.bibata-cursors;
        name = "Bibata-Modern-Classic";
        size = 24;
    };

    dconf.settings."org/gnome/desktop/interface".color-scheme = "prefer-dark";

    qt = {
        enable = true;
        platformTheme.name = "kvantum";
        style.name = "kvantum";
    };
}