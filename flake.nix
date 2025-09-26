{
    description = "Main System Flake";

    inputs = {
        nixpkgs.url = "nixpkgs/nixos-unstable";
        
        home-manager = {
            url = "github:nix-community/home-manager/master";
            inputs.nixpkgs.follows = "nixpkgs";
        };
        
        hyprland.url = "github:hyprwm/Hyprland";
        hyprland-plugins = {
            url = "github:hyprwm/hyprland-plugins";
            inputs.hyprland.follows = "hyprland";
        };
        split-monitor-workspaces = {
            url = "github:Duckonaut/split-monitor-workspaces";
            inputs.hyprland.follows = "hyprland"; # <- make sure this line is present for the plugin to work as intended
        };

        nixos-xivlauncher-rb = {
            url = "github:The1Penguin/nixos-xivlauncher-rb";
            inputs.nixpkgs.follows = "nixpkgs";
        };
        
        zen-browser = {
            url = "github:0xc000022070/zen-browser-flake";
            inputs.nixpkgs.follows = "nixpkgs";
        };

        nix-gaming.url = "github:fufexan/nix-gaming";

        nix-citizen.url = "github:LovingMelody/nix-citizen";
    };

    outputs = inputs@{ self, nixpkgs, home-manager, split-monitor-workspaces, zen-browser, nix-gaming, nix-citizen, nixos-xivlauncher-rb,... }:
        let
            inherit (self) outputs;
            lib = nixpkgs.lib;
            system = "x86_64-linux";
            pkgs = nixpkgs.legacyPackages.${system};
        in {
            nixosConfigurations = {
                erin-desktop = lib.nixosSystem {
                    inherit system;
                    specialArgs = { inherit inputs outputs; };
                    modules = [ ./configuration.nix ];
                };
            };
            homeConfigurations = {
                erin = home-manager.lib.homeManagerConfiguration {
                    inherit pkgs;
                    extraSpecialArgs = { inherit inputs outputs; };
                    modules = [ ./home/home.nix ];
                };
            };
        };
}
