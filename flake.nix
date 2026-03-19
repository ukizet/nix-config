{
  description = "My system flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    nixpkgs-stable.url = "github:nixos/nixpkgs/nixos-25.11";
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
    noctalia = {
      url = "github:noctalia-dev/noctalia-shell";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    zen-browser = {
      url = "github:youwen5/zen-browser-flake";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nix-openclaw.url = "github:openclaw/nix-openclaw";
    zeroclaw.url = "github:zeroclaw-labs/zeroclaw";
  };

  outputs = inputs @ {
    self,
    nixpkgs,
    nixpkgs-stable,
    home-manager,
    nix-openclaw,
    zeroclaw,
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
        android_sdk.accept_license = true;
        permittedInsecurePackages = [
          "openclaw-2026.2.26"
        ];
      };
      overlays = [nix-openclaw.overlays.default nur.overlays.default];
    }; # just conifguration of pkgs (unstable) to allowUnfree
    pkgs-stable = import nixpkgs-stable {
      inherit system;
      config = pkgs.config;
    }; # just conifguration of pkgs to allowUnfree
  in {
    nixosConfigurations.nixos = lib.nixosSystem {
      specialArgs = {
        inherit pkgs;
        inherit pkgs-stable;
        inherit inputs;
      };
      inherit system;
      modules = [
        ./nixos/configuration.nix
        # home-manager.nixosModules.home-manager
        # {
        #   home-manager = {
        #     useGlobalPkgs = true;
        #     useUserPackages = true;
        #     users.sas = import ./home/home.nix;
        #     backupFileExtension = "backup";
        #   };
        # }
        inputs.nix-flatpak.nixosModules.nix-flatpak
        inputs.nvf.nixosModules.default
        # Adds the NUR overlay
        nur.modules.nixos.default
        # NUR modules to import
        nur.legacyPackages."${system}".repos.iopq.modules.xraya
        # zeroclaw.nixosModules.default
      ];
    };
  };
}
