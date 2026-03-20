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
    # ./DE/kde.nix
    ./packages.nix
    ./programs.nix
    ./virtualisation.nix
    ./networking.nix
    ./localisation.nix
    ./sessionVariables.nix
    ./font.nix
    ./WM/niri.nix
    ./services.nix
    # ./WM/hyprland.nix
    # ./dwm/default.nix
    # ./nextcloud.nix
    ./laptop.nix
  ];

  #  services.llama-cpp = {
  #  enable = true;
  #  package = pkgs.llama-cpp-vulkan;
  #};

  time.timeZone = "Europe/Oslo";

  users = {
    mutableUsers = false;
    users.sas = {
      hashedPassword = "$6$xTJiC6pPGBqUiUHe$XNM9CHPjlR4m.JMMdIAGME.A.A1XRzVA3siqZzChlTlRIjUyhVdnzDqS5y6Q3mYpGG1akPIj7D4HMuYQAhTcv0";
      openssh.authorizedKeys.keys = ["ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIAD8QmN5irwr+2VFYj4GefgtE9oKAJIPZFyozvpn+yLT termux"];
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
      cores = 4;
      max-jobs = 1;
    };
    extraOptions = ''
      trusted-users = root sas
    '';
  };
  system.stateVersion = "23.05";
}
