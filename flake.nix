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
    nur = {
      url = "github:nix-community/NUR";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    yt-x = {
      url = "github:Benexl/yt-x";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = inputs @ {
    self,
    nixpkgs,
    nixpkgs-stable,
    home-manager,
    nur,
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
      overlays = [nur.overlays.default];
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
          home-manager = {
            useGlobalPkgs = true;
            useUserPackages = true;
            users.sas = import ./home/home.nix;
            backupFileExtension = "backup";
          };

          # Optionally, use home-manager.extraSpecialArgs to pass arguments to home.nix
        }
        inputs.nix-flatpak.nixosModules.nix-flatpak
        inputs.nvf.nixosModules.default
        # Adds the NUR overlay
        nur.modules.nixos.default
        # NUR modules to import
        nur.legacyPackages."${system}".repos.iopq.modules.xraya
      ];
      specialArgs = {
        inherit pkgs;
        inherit pkgs-stable;
        inherit inputs;
      };
    };
  };
}
