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
    ./kde.nix
    ./packages.nix
    ./programs.nix
    ./variables.nix
    ./virtualisation.nix
    # ./nextcloud.nix
  ];

  networking = {
    hostName = "nixos"; # Define your hostname.
    networkmanager.enable = true;
  };

  time.timeZone = "Europe/Oslo";

  i18n = {
    defaultLocale = "en_US.UTF-8";
    extraLocaleSettings = {
      LC_ADDRESS = "uk_UA.UTF-8";
      LC_IDENTIFICATION = "uk_UA.UTF-8";
      LC_MEASUREMENT = "uk_UA.UTF-8";
      LC_MONETARY = "uk_UA.UTF-8";
      LC_NAME = "uk_UA.UTF-8";
      LC_NUMERIC = "uk_UA.UTF-8";
      LC_PAPER = "uk_UA.UTF-8";
      LC_TELEPHONE = "uk_UA.UTF-8";
      LC_TIME = "uk_UA.UTF-8";
    };
  };

  security = {
    rtkit.enable = true;
  };

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
      ];
    };
    defaultUserShell = pkgs.zsh;
  };

  systemd.services = {
    "getty@tty1".enable = false;
    "autovt@tty1".enable = false;
    "ratbagd".enable = true;
  };

  fonts.packages = with pkgs; [
    nerd-fonts.fira-code
  ];

  nix = {
    optimise = {
      automatic = true;
      dates = ["weekly"];
    };
    settings = {
      experimental-features = [
        "nix-command"
        "flakes"
      ];
      cores = 4;
      max-jobs = 2;
    };
    extraOptions = ''
      trusted-users = root sas
    '';
  };
  system.stateVersion = "23.05";
}
