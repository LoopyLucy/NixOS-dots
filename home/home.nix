{ inputs, pkgs, ... }:

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
            GDK_BACKEND = "wayland,x11,*";
            CLUTTER_BACKEND = "wayland";
            QT_QPA_PLATFORM = "wayland;xcb";

            NIXOS_OZONE_WL = 1;
            NIXPKGS_ALLOW_UNFREE = 1;
            SHELL = "zsh";
        };

        stateVersion = "25.05";
    };

    nixpkgs.config = {
        allowUnfree = true;
        permittedInsecurePackages = [
            "electron-39.8.10"
            "electron-40.10.5"
        ];
    };

    fonts.fontconfig.enable = true;
    home.packages = with pkgs; [
        #Software
        inputs.zen-browser.packages."${stdenv.hostPlatform.system}".default
        brave
        bitwarden-desktop
        logiops
        #(bottles.override {removeWarningPopup = true;})
        kdePackages.qtwebengine
        calibre
        obs-studio
        discord
        vencord
        element-desktop
        jetbrains.idea-oss #Intellij IDEA OSS
        vlc
        blockbench
        blender
        android-studio
        obsidian
        krita
        krita-plugin-gmic
        deluge
        audacity
        qalculate-qt
        pixelorama
        godot
        #openrgb

        #Games
        #inputs.nix-gaming.packages.${pkgs.stdenv.hostPlatform.system}.star-citizen
        #inputs.nix-citizen.packages.${stdenv.hostPlatform.system}.star-citizen
        #inputs.nix-citizen.packages.${stdenv.hostPlatform.system}.star-citizen-git
        inputs.nix-citizen.packages.${stdenv.hostPlatform.system}.star-citizen-umu
        xivlauncher
        #modrinth-app
        #prismlauncher

        #Game Tools / Launchers
        heroic-unwrapped

        #Tools
        xdg-desktop-portal-gtk
        
        wev
        piper
        dconf
        btop
        unzip
        p7zip
        peazip
        rar
        winetricks
        protontricks
        imv
        wtype

        #limo
        #steamtinkerlaunch

        #Themeing
        zsh-powerlevel10k

        #Fonts
        meslo-lgs-nf
        nerd-fonts.jetbrains-mono
    ];

    gtk.gtk4.theme = null;

    xdg.mimeApps = {
        enable = true;
        defaultApplications = {
            "text/html" = "zen-beta.desktop";
            "x-scheme-handler/http" = "zen-beta.desktop";
            "x-scheme-handler/https" = "zen-beta.desktop";
            "application/vnd.openxmlformats-officedocument.wordprocessingml.document" = "writer.desktop";
            "inode/directory" = ["thunar.desktop"];
            "x-scheme-handler/file" = [ "thunar.desktop" ];
            "text/plain" = "code.desktop";
            "image/jpeg" = "imv.desktop";
            "image/png" = "imv.desktop";
            "image/gif" = "imv.desktop";
            "image/webp" = "imv.desktop";
        };
    };

    xdg.desktopEntries = {
        "vesktop" = {
            name = "Vesktop";
            genericName = "Internet Messenger";
            exec = "${pkgs.vesktop}/bin/vesktop --enable-features=UseOzonePlatform,VaapiVideoDecoder,VaapiVideoEncoder --ozone-platform=wayland";
            icon = "vesktop";
            type = "Application";
            terminal = false;
            categories = [ "Network" "InstantMessaging" "Chat" ];
            comment = "Vesktop with native Wayland and VA-API flags enabled via Home Manager";
        };
    };

    xdg.portal = {
        enable = true;
        extraPortals = [ pkgs.xdg-desktop-portal-gtk ];
        config = {
            common = {
            default = [ "hyprland" "gtk" ];
            };
            hyprland = {
            default = [ "hyprland" "gtk" ];
            };
        };
    };

    programs.nix-your-shell.enable = true;
    programs.fastfetch.enable = true;
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

            #buildhome = "home-manager switch --flake ~/.nixos";
            #buildnix = "sudo nixos-rebuild switch --flake ~/.nixos";
            buildhome = "nh home switch ~/.nixos";
            buildnix = "nh os switch ~/.nixos";
        };
    };

    programs.zsh = {
        enable = true;

        shellAliases = {
            ll = "ls -l";
            ".." = "cd ..";
            la = "ls -a";
            ff = "fastfetch";
            c = "clear";
            f = "y";

            buildhome = "nh home switch ~/.nixos";
            buildnix = "nh os switch ~/.nixos";
        };

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
            "editor.tabSize" = 4;
            "editor.detectIndentation" = false;
            "editor.formatOnSave" = true;
            "editor.formatOnPaste" = true;
            "terminal.integrated.fontLigatures.enabled" = true;
            "git.confirmSync" = false;
            "git.enableSmartCommit" = true;
        };
    };

    programs.yazi = {
        enable = true;
        enableZshIntegration = true;
        shellWrapperName = "y";
        settings.opener.edit = [{
            run = "nvim \"$@\"";
            block = true;
            desc = "Edit with Neovim";
        }];
    };

    programs.git = {
        enable = true;
        settings = {
            user.name = "LoopyLucy";
            user.email = "erinlucyfitton@outlook.com";

            init.defaultBranch = "mistress";
        };
    };

    programs.home-manager.enable = true; #required
}
