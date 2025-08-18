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
    lib = nixpkgs.lib;
    pkgs = import nixpkgs {
      inherit system;
      config = {
        allowUnfree = true;
        allowUnfreePredicate = true;
        #permittedInsecurePackages = [
        #"archiver-3.5.1"
        #];
      };
    };
    pkgs-stable = import nixpkgs-stable {
      inherit system;
      config = pkgs.config;
    };
  in {
    nixosConfigurations.nixos = lib.nixosSystem {
      inherit system;
      modules = [
        ./nixos/configuration.nix
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
