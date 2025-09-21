{
    description = "Main System Flake";

    inputs = {
        nixpkgs.url = "nixpkgs/nixos-unstable";
        home-manager = {
            url = "github:nix-community/home-manager/master";
            inputs.nixpkgs.follows = "nixpkgs";
        };
        zen-browser.url = "github:0xc000022070/zen-browser-flake";
    };

    outputs = { self, nixpkgs, home-manager, zen-browser, ... }:
        let
            lib = nixpkgs.lib;
            system = "x86_64-linux";
            pkgs = nixpkgs.legacyPackages.${system};
        in {
            nixosConfigurations = {
                erin-desktop = lib.nixosSystem {
                    inherit system;
                    modules = [ ./configuration.nix ];
                };
            };
            homeConfigurations = {
                erin = home-manager.lib.homeManagerConfiguration {
                    inherit pkgs;
                    modules = [ ./home.nix ];
                };
            };
        };
}
