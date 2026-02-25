{
  config,
  pkgs,
  pkgs-stable,
  inputs,
  ...
}: {
  imports = [
    ./audio.nix
    ./bluetooth.nix
    ./boot.nix
    ./flatpak.nix
    ./graphics.nix
    ./hardware-configuration.nix
    ./DE/kde.nix
    ./packages.nix
    ./programs.nix
    ./virtualisation.nix
    ./networking.nix
    ./localisation.nix
    ./sessionVariables.nix
    ./font.nix
    ./WM/niri.nix
    # ./WM/hyprland.nix
    # ./dwm/default.nix
    # ./nextcloud.nix
  ];

  # laptop related settings
  powerManagement.enable = true;
  services.thermald.enable = true;

  time.timeZone = "Europe/Oslo";

  users = {
    users.sas = {
      isNormalUser = true;
      description = "sas";
      extraGroups = [
        "networkmanager"
        "wheel"
        "docker"
        "realtime"
        "audio"
        "jackuser"
        "kvm"
      ];
    };
    defaultUserShell = pkgs.zsh;
  };

  systemd = {
    services = {
      "getty@tty1".enable = false;
      "autovt@tty1".enable = false;
      "ratbagd".enable = true;
    };
  };

  nixpkgs.config.packageOverrides = pkgs: {
    nur = import (builtins.fetchTarball "https://github.com/nix-community/NUR/archive/main.tar.gz") {
      inherit pkgs;
    };
  };
  zramSwap.enable = true;

  nix = {
    optimise.automatic = true;
    gc = {
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than 14d";
    };
    settings = {
      auto-optimise-store = true;
      experimental-features = [
        "nix-command"
        "flakes"
      ];
      # cores = 4;
      # max-jobs = 2;
    };
    extraOptions = ''
      trusted-users = root sas
    '';
  };
  system.stateVersion = "23.05";
}
