{
  description = "My system flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    nixpkgs-stable.url = "github:nixos/nixpkgs/nixos-25.05";
    nix-flatpak.url = "github:gmodena/nix-flatpak"; # unstable branch. Use github:gmodena/nix-flatpak/?ref=<tag> to pin releases.
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nvf.url = "github:notashelf/nvf";
  };

  outputs = inputs @ {
    self,
    nixpkgs,
    nixpkgs-stable,
    home-manager,
    ...
  }: let
    system = "x86_64-linux";
    lib = nixpkgs.lib; # like some shortcut for lib
    pkgs = import nixpkgs {
      inherit system;
      config = {
        allowUnfree = true;
        allowUnfreePredicate = true;
      };
    }; # just conifguration of pkgs (unstable) to allowUnfree
    pkgs-stable = import nixpkgs-stable {
      inherit system;
      config = pkgs.config;
    }; # just conifguration of pkgs to allowUnfree
  in {
    nixosConfigurations.nixos = lib.nixosSystem {
      inherit system;
      modules = [
        ./nixos/configuration.nix
        home-manager.nixosModules.home-manager
        {
          home-manager.useGlobalPkgs = true;
          home-manager.useUserPackages = true;
          home-manager.users.sas = import ./nixos/home/home.nix;
          home-manager.backupFileExtension = "backup";

          # Optionally, use home-manager.extraSpecialArgs to pass arguments to home.nix
        }
        inputs.nix-flatpak.nixosModules.nix-flatpak
        inputs.nvf.nixosModules.default
      ];
      specialArgs = {
        inherit pkgs;
        inherit pkgs-stable;
      };
    };
  };
}
