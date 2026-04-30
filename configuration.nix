 # Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, lib, inputs, pkgs, ... }:

{
  imports = [
    ./hardware-configuration.nix
    #inputs.nix-gaming.nixosModules.steamCompat
    inputs.nix-gaming.nixosModules.platformOptimizations
    inputs.nix-gaming.nixosModules.wine
  ];

  hardware = {
    bluetooth.enable = true;
    steam-hardware.enable = true;
  };

  boot = {
    loader = {
      systemd-boot.enable = true;
      efi.canTouchEfiVariables = true;
    };

    kernelPackages = pkgs.linuxPackages_latest;

    extraModulePackages = with config.boot.kernelPackages; [ v4l2loopback ];
    kernelModules = [ "v4l2loopback" "uinput" ];
    extraModprobeConfig = ''
      options v4l2loopback video_nr=2,3 width=640,1920 max_width=1920 height=480,1080 max_height=1080 format=YU12,YU12 exclusive_caps=1,1 card_label=Phone,Laptop debug=1
    '';
  };

  users.users.erin = {
    isNormalUser = true;
    description = "Erin Lucy Fitton";
    extraGroups = [ "networkmanager" "wheel" ];
    shell = pkgs.zsh;

    packages = with pkgs; [
      kdePackages.kate
      thunderbird
      gparted
    ];
  };

  security.polkit.enable = true;
  security.rtkit.enable = true;

  networking = {
    hostName = "erin-desktop";
    networkmanager.enable = true;

    firewall = {
      enable = true;
      allowPing = true;
      extraCommands = ''iptables -t raw -A OUTPUT -p udp -m udp --dport 137 -j CT --helper netbios-ns'';
      # Open ports in the firewall.
      #allowedTCPPorts = [ ... ];
      #allowedUDPPorts = [ ... ];
    };
  };

  time.timeZone = "Europe/London";

  i18n = {
    defaultLocale = "en_GB.UTF-8";
    extraLocaleSettings = {
      LC_ADDRESS = "en_GB.UTF-8";
      LC_IDENTIFICATION = "en_GB.UTF-8";
      LC_MEASUREMENT = "en_GB.UTF-8";
      LC_MONETARY = "en_GB.UTF-8";
      LC_NAME = "en_GB.UTF-8";
      LC_NUMERIC = "en_GB.UTF-8";
      LC_PAPER = "en_GB.UTF-8";
      LC_TELEPHONE = "en_GB.UTF-8";
      LC_TIME = "en_GB.UTF-8";
    };
  };

  services = {
    desktopManager.plasma6.enable = true;

    pulseaudio.enable = false;
    flatpak.enable = true;
    ratbagd.enable = true;
    openssh.enable = true;
    tumbler.enable = true;

    tailscale.enable = true;

    blueman = {
      enable = true;
      withApplet = true;
    };

    displayManager = {
      autoLogin.enable = true;
      autoLogin.user = "erin";
      sessionPackages = [ inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.hyprland ];
      defaultSession = "hyprland";
      sddm = {
        enable = true;
        wayland.enable = true;
      };
    };

    xserver.xkb = {
      layout = "gb";
      variant = "";
    };

    samba = {
      enable = true;
      openFirewall = true;
      settings = {
        global = {
          "workgroup" = "WORKGROUP";
          "server string" = "smbnix";
          "netbios name" = "smbnix";
          "security" = "user";
          #"use sendfile" = "yes";
          #"max protocol" = "smb2";
          # note: localhost is the ipv6 localhost ::1
          "hosts allow" = "192.168.0. 127.0.0.1 localhost";
          "hosts deny" = "0.0.0.0/0";
          "guest account" = "nobody";
          "map to guest" = "bad user";
        };
        "public" = {
          "path" = "/mnt/Shares/Public";
          "browseable" = "yes";
          "read only" = "no";
          "guest ok" = "yes";
          "create mask" = "0644";
          "directory mask" = "0755";
          "force user" = "username";
          "force group" = "groupname";
        };
        "private" = {
          "path" = "/mnt/Shares/Private";
          "browseable" = "yes";
          "read only" = "no";
          "guest ok" = "no";
          "create mask" = "0644";
          "directory mask" = "0755";
          "force user" = "username";
          "force group" = "groupname";
        };
      };
    };
    
    samba-wsdd = {
      enable = true;
      openFirewall = true;
    };

    avahi = {
      enable = true;
      nssmdns4 = true;
      openFirewall = true;
      publish = {
        enable = true;
        userServices = true;
      };
    };

    printing = {
      enable = true;
      drivers = with pkgs; [
        cups-filters
        cups-browsed
        gutenprint
      ];
  
      listenAddresses = [ "*:631" ];
      allowFrom = [ "all" ];
      browsing = true;
      defaultShared = true;
      openFirewall = true;
    };

    pipewire = {
      enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;
    };

    gvfs = {
      enable = true;
      package = lib.mkForce pkgs.gnome.gvfs;
    };

    udev.packages = with pkgs; [ game-devices-udev-rules ];
  };

  environment = {
    sessionVariables.NIXOS_OZONE_WL = "1";

    systemPackages = with pkgs; [
      pkgs.cifs-utils
      (pkgs.prismlauncher.override {
        jdks = [
          pkgs.temurin-bin-21
          pkgs.temurin-bin-17
          pkgs.temurin-bin-8
        ];
      })
      zenity
      vulkan-loader
      libX11
      libXcursor
      libXrandr
      samba
      libratbag
      v4l-utils
      blueman
      android-tools
      libnotify
      glib
      usbutils
      temurin-bin-21
      xrandr
      socat
    ];

    shells = with pkgs; [ 
      zsh 
      bashInteractive
    ];
  };

  fonts = {
    packages = with pkgs; [
      noto-fonts
      noto-fonts-cjk-sans
      noto-fonts-cjk-serif
      noto-fonts-color-emoji
    ];

    fontconfig.defaultFonts = {
        serif = [ "Noto Serif" "Noto Serif CJK JP" ];
        sansSerif = [ "Noto Sans" "Noto Sans CJK JP" ];
        monospace = [ "Noto Sans Mono" "Noto Sans Mono CJK JP" ];
    };
  };

  console.keyMap = "uk";

  #hardware.printers.ensurePrinters = [
  #  {
  #    name = "Dell_1250c";
  #    location = "Home";
  #    deviceUri = "usb://Dell/1250c%20Color%20Printer?serial=YNP023240";
  #    model = "Dell-1250c.ppd.gz";
  #    ppdOptions = {
  #      PageSize = "A4";
  #    };
  #  }
  #];

  programs = {
    xfconf.enable = true;

    nix-ld.enable = true;
    nix-ld.libraries = with pkgs; [
      temurin-bin-21
      libGL
      libpulseaudio
      stdenv.cc.cc
      libX11
      libXcursor
      libXrandr
      libXinerama
      # Wayland support
      glfw3-minecraft 
      libdecor
    ];

    alvr = { 
      enable = true; 
      openFirewall = true;
    };

    nh = {
      enable = true;
      clean.enable = true;
      clean.extraArgs = "--keep-since 4d --keep 3";
      flake = "/home/user/my-nixos-config"; # sets NH_OS_FLAKE variable for you
    };

    thunar = {
      enable = true;
      plugins = with pkgs; [
        thunar-archive-plugin
        thunar-volman
        thunar-vcs-plugin
        thunar-media-tags-plugin
      ];
    };

    gamescope = {
      enable = true;
      capSysNice = true;
    };

    steam = {
      enable = true;
      gamescopeSession.enable = true;
      platformOptimizations.enable = true;
      remotePlay.openFirewall = true;
      dedicatedServer.openFirewall = true;
      extraCompatPackages = with pkgs; [
        proton-ge-bin
      ];
    };

    zsh = {
      enable = true;
  
      enableCompletion = true;
      autosuggestions.enable = true;
      syntaxHighlighting.enable = true;
  
      ohMyZsh = {
        enable = true;
        plugins = ["git" "sudo"];
      };
  
      histSize = 10000;
    };

    nvf = {
      enable = true;
      settings = {
        vim = {
          theme = {
            enable = true;
            name = "tokyonight";
            style = "night";
          };

          binds = {
            whichKey.enable = true;
          };
          
          languages = {
            #enableLSP = true;
            enableTreesitter = true;
            enableExtraDiagnostics = true;
            nix.enable = true;
            java.enable = true;
            rust.enable = true;
            typescript.enable = true;
            json.enable = true;
          };

          lsp = {
            enable = true;
            trouble.enable = true;
          };
          
          statusline.lualine.enable = true;
          telescope.enable = true;
          lazy.enable = true;
          ui.noice.enable = true;
          diagnostics.nvim-lint.enable = true;
          notes.todo-comments.enable = true;

          dashboard.startify.sessionPersistence = true;

          autocomplete.blink-cmp = {
            enable = true;
            friendly-snippets.enable = true;
          };

          filetree.neo-tree.enable = true;

          mini = {
            ai.enable = true;
            icons.enable = true;
            pairs.enable = true;
          };

          tabline.nvimBufferline.enable = true;

          utility.motion.flash-nvim.enable = true;

          clipboard = {
            enable = true;
            providers.wl-copy.enable = true;
          };

          options = {
            clipboard = lib.mkForce "unnamedplus";
          };

          extraPackages = with pkgs; [
            wl-clipboard
          ];
        };
      };
    };
  };

  nixpkgs.config = {
    allowUnfree = true;
  };

  # In your home-manager or nixos configuration
  nixpkgs.overlays = [
    (final: prev: {
      openldap = prev.openldap.overrideAttrs (oldAttrs: {
        doCheck = false;
      });
    })
  ];


  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "25.05"; # Did you read the comment?

  nix.settings = {
    experimental-features = [ "nix-command" "flakes" ];

    substituters = [
      "https://hyprland.cachix.org"
      "https://nix-gaming.cachix.org"
      "https://nix-citizen.cachix.org"
    ];

    trusted-substituters = [
      "https://hyprland.cachix.org"
      "https://nix-gaming.cachix.org"
      "https://nix-citizen.cachix.org"
    ];
    
    trusted-public-keys = [
      "hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc="
      "nix-gaming.cachix.org-1:nbjlureqMbRAxR1gJ/f3hxemL9svXaZF/Ees8vCUUs4="
      "nix-citizen.cachix.org-1:lPMkWc2X8XD4/7YPEEwXKKBg+SVbYTVrAaLA2wQTKCo="
    ];
  };
}
