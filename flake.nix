{
    description = "Main System Flake";

    inputs = {
        nixpkgs.url = "nixpkgs/nixos-unstable";
        
        home-manager = {
            url = "github:nix-community/home-manager/master";
            inputs.nixpkgs.follows = "nixpkgs";
        };
        
        hyprland.url = "github:hyprwm/Hyprland";
        
        zen-browser = {
            url = "github:0xc000022070/zen-browser-flake";
            inputs.nixpkgs.follows = "nixpkgs";
        };
    };

    outputs = inputs@{ self, nixpkgs, home-manager, zen-browser, ... }:
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
