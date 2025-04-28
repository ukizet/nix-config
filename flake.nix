{
  description = "My system flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-24.11";
    nixpkgs-unstable.url = "github:NixOS/nixpkgs/nixos-unstable";
    nix-flatpak.url = "github:gmodena/nix-flatpak"; # unstable branch. Use github:gmodena/nix-flatpak/?ref=<tag> to pin releases.
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs-unstable";
    };
    nvf.url = "github:notashelf/nvf";
  };

  outputs =
    inputs@{
      self,
      nixpkgs,
      nixpkgs-unstable,
      home-manager,
      ...
    }:
    let
      system = "x86_64-linux";
      lib = nixpkgs.lib;
      username = "sas";
      pkgs = (import nixpkgs {
        inherit system;
        config = {
          allowUnfree = true;
          allowUnfreePredicate = (_: true);
          permittedInsecurePackages = [
            "archiver-3.5.1"
          ];
        };
      });
      pkgs-unstable = (import nixpkgs-unstable {
        inherit system;
        config = pkgs.config;
      });
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
          inherit pkgs-unstable;
        };
      };
      homeConfigurations.${username} = home-manager.lib.homeManagerConfiguration {
        inherit pkgs-unstable;

        # Specify your home configuration modules here, for example,
        # the path to your home.nix.
        modules = [ ./nixos/home.nix ];

        # Optionally use extraSpecialArgs
        # to pass through arguments to home.nix
      };
    };
}
