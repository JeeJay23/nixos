{
  description = "Nixos config flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    nixpkgs-stable.url = "github:nixos/nixpkgs/nixos-24.05";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, nixpkgs-stable, ... }@inputs: {
    nixosConfigurations.default = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      specialArgs = {
        inherit inputs;
        pkgs-stable = import nixpkgs-stable {
            system = "x86_64-linux";
            config.allowUnfree = true;
        };
      };
      
      modules = [
        ./hosts/default/configuration.nix
        ./modules/nvidia.nix
        ./modules/cinnamon-de.nix
        ./modules/plasma-de.nix
      ];

    };
  };
}
