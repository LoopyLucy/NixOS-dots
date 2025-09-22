{ config, inputs, pkgs, ... }:

{

    imports = [

        ../hyprland/hyprland.nix

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

    nixpkgs.config.allowUnfree = true;

    # This value determines the Home Manager release that your configuration is
    # compatible with. This helps avoid breakage when a new Home Manager release
    # introduces backwards incompatible changes.
    #
    # You should not change this value, even if you update Home Manager. If you do
    # want to update the value, then make sure to first check the Home Manager
    # release notes.
    # Please read the comment before changing.

    # The home.packages option allows you to install Nix packages into your
    # environment.
    fonts.fontconfig.enable = true;
    home.packages = with pkgs; [
        #Software
        inputs.zen-browser.packages."${system}".default
        logiops

        #Fonts
        meslo-lgs-nf
        nerd-fonts.jetbrains-mono
    ];

    # Home Manager is pretty good at managing dotfiles. The primary way to manage
    # plain files is through 'home.file'.

    # Home Manager can also manage your environment variables through
    # 'home.sessionVariables'. These will be explicitly sourced when using a
    # shell provided by Home Manager. If you don't want to manage your shell
    # through Home Manager then you have to manually source 'hm-session-vars.sh'
    # located at either
    #
    #  ~/.nix-profile/etc/profile.d/hm-session-vars.sh
    #
    # or
    #
    #  ~/.local/state/nix/profiles/profile/etc/profile.d/hm-session-vars.sh
    #
    # or
    #
    #  /etc/profiles/per-user/erin/etc/profile.d/hm-session-vars.sh
    #

    programs.vscode.enable = true;
    programs.bash.enable = true;
    programs.kitty.enable = true;
    programs.neovim.enable = true;
    programs.vesktop.enable = true;

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
