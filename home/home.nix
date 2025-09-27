{ config, services, inputs, pkgs, split-monitor-workspaces, ... }:

{

    imports = [

        ./hyprland/hyprland.nix
        ./theme/theme.nix

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

    nixpkgs.config = {
        allowUnfree = true;
    };

    fonts.fontconfig.enable = true;
    home.packages = with pkgs; [
        #Software
        inputs.zen-browser.packages."${system}".default
        bitwarden
        logiops
        bottles
        kdePackages.qtwebengine

        #Games
        #inputs.nix-gaming.packages.${pkgs.system}.star-citizen
        #inputs.nix-citizen.packages.${system}.star-citizen
        #inputs.nix-citizen.packages.${system}.star-citizen-git
        inputs.nix-citizen.packages.${system}.star-citizen-umu
        xivlauncher
        modrinth-app

        #Tools
        wev
        piper
        dconf

        #Fonts
        meslo-lgs-nf
        nerd-fonts.jetbrains-mono
    ];

    #programs.vscode.enable = true;
    programs.fastfetch.enable = true;
    programs.kitty.enable = true;
    programs.neovim.enable = true;
    programs.vesktop.enable = true;
    
    programs.bash = {
        enable = true;
        shellAliases = {
            ll = "ls -l";
            ".." = "cd ..";
            la = "ls -a";
            ff = "fastfetch";

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
