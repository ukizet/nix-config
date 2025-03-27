{
  description = "My system flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-24.11";
    unstable.url = "github:NixOS/nixpkgs/nixos-unstable";
    nix-flatpak.url = "github:gmodena/nix-flatpak"; # unstable branch. Use github:gmodena/nix-flatpak/?ref=<tag> to pin releases.
    home-manager = {
      url = "github:nix-community/home-manager/release-24.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nvf.url = "github:notashelf/nvf";
  };

  outputs = inputs@{ self, nixpkgs, unstable, nix-flatpak, home-manager, nvf, ... }:
    let
      system = "x86_64-linux";
    in
    {
      packages."x86_64-linux".default = 
        (nvf.lib.neovimConfiguration {
          pkgs = nixpkgs.legacyPackages."x86_64-linux";
          modules = [ ./nixos/nvf-configuration.nix ]
        });
      nixosConfigurations.nixos = nixpkgs.lib.nixosSystem {
        specialArgs = {
          pkgs = import nixpkgs {
            inherit system;
            config = {
              allowUnfree = true;
              nvidia.acceptLicense = true;
            };
          };
          inherit inputs system;
        };

        modules = [
          ./nixos/configuration.nix
          {
            nixpkgs.config.permittedInsecurePackages = [
              "electron-27.3.11"
            ];
          }
          nix-flatpak.nixosModules.nix-flatpak
          home-manager.nixosModules.home-manager
          {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.users.sas = import nixos/home.nix;

            # Optionally, use home-manager.extraSpecialArgs to pass
            # arguments to home.nix
          }
          nvf.nixosModules.default
        ];
      };
    };
}
  
