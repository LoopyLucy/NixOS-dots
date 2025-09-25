{ config, services, inputs, pkgs, ... }:

{

    imports = [

        ./hyprland/hyprland.nix

    ];

    home = {
        username = "erin";
        homeDirectory = "/home/erin";

        file = {};

        sessionVariables = {
            NIXOS_OZONE_WL = 1;
            NIXPKGS_ALLOW_UNFREE = 1;
        };

        stateVersion = "25.05";
    };

    gtk = {
        enable = true;
        theme = {
            name = "Breeze-Dark";
            package = pkgs.kdePackages.breeze-gtk;
        };
    };

    qt = {
        enable = true;
        platformTheme.name = "kvantum";
        style.name = "kvantum";
    };
    #qt.enable = true;

    nixpkgs.config = {
        allowUnfree = true;
        nixpkgs.config.permittedInsecurePackages = [
            "qtwebengine"
        ];
    };

    fonts.fontconfig.enable = true;
    home.packages = with pkgs; [
        #Software
        inputs.zen-browser.packages."${system}".default
        bitwarden
        logiops
        bottles
        kdePackages.qtwebengine
        #stremio #(fluppered)

        #Tools
        wev
        piper
        dconf

        #Fonts
        meslo-lgs-nf
        nerd-fonts.jetbrains-mono
    ];

    #programs.vscode.enable = true;
    programs.kitty.enable = true;
    programs.neovim.enable = true;
    programs.vesktop.enable = true;
    
    programs.bash = {
        enable = true;
        shellAliases = {
            ll = "ls -l";
            ".." = "cd ..";
            la = "ls -a";

            buildhome = "home-manager switch --flake ~/.nixos";
            buildnix = "sudo nixos-rebuild switch --flake ~/.nixos";
        };
    };

    programs.vscode = {
        enable = true;
        profiles.default.userSettings = {
            "editor.fontFamily" = "JetBrainsMono Nerd Font";
            "editor.fontLigatures" = true;
            "terminal.integrated.fontLigatures.enabled" = true;
            "git.confirmSync" = false;
            "git.enableSmartCommit" = true;
        };
    };

    programs.git = {
        enable = true;
        userName = "LoopyLucy";
        userEmail = "erinlucyfitton@outlook.com";
        extraConfig = {
            init.defaultBranch = "mistress";
        };
    };

    programs.home-manager.enable = true; #required
}
