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

        shell.enableZshIntegration = true;

        sessionVariables = {
            NIXOS_OZONE_WL = 1;
            NIXPKGS_ALLOW_UNFREE = 1;
            SHELL = "zsh";
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
        (bottles.override {removeWarningPopup = true;})
        kdePackages.qtwebengine
        calibre
        obs-studio
        discord
        vencord
        jetbrains.idea-community #Intellij IDEA Community


        #Games
        #inputs.nix-gaming.packages.${pkgs.system}.star-citizen
        #inputs.nix-citizen.packages.${system}.star-citizen
        #inputs.nix-citizen.packages.${system}.star-citizen-git
        inputs.nix-citizen.packages.${system}.star-citizen-umu
        xivlauncher
        modrinth-app

        #Tools
        btop
        wev
        piper
        dconf
        unzip
        p7zip
        rar
        winetricks
        protontricks
        xdg-desktop-portal-gtk
        limo
        #steamtinkerlaunch

        #Themeing
        zsh-powerlevel10k

        #Fonts
        meslo-lgs-nf
        nerd-fonts.jetbrains-mono
    ];

    programs.nix-your-shell.enable = true;
    programs.fastfetch.enable = true;
    programs.neovim.enable = true;
    programs.vesktop.enable = true;
    
    programs.kitty = { 
        enable = true;
        shellIntegration.enableZshIntegration = true;

        settings = {
            confirm_os_window_close = 0;
            enable-audio-bell = 0;
        };
    };

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

    programs.zsh = {
        enable = true;
        plugins = [
            {
                name = "powerlevel10k-config";
                src = ./p10k;
                file = "p10k.zsh";
            }
            {
                name = "zsh-powerlevel10k";
                src = "${pkgs.zsh-powerlevel10k}/share/zsh-powerlevel10k/";
                file = "powerlevel10k.zsh-theme";
            }
        ];
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

    programs.yazi = {
        enable = true;
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
