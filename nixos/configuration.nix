{ config, pkgs, ... }:

{
  imports =
    [
      # Include the results of the hardware scan.
      ./hardware-configuration.nix
    ];

  boot.loader = {
    systemd-boot.enable = true;
    efi.canTouchEfiVariables = true;
  };

  networking = {
    hostName = "nixos"; # Define your hostname.
    networkmanager.enable = true;
  };

  # Set your time zone.
  time.timeZone = "Europe/Kyiv";

  # Select internationalisation properties.
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

  services = {
    xserver = {
      # Enable the X11 windowing system.
      enable = true;

      # Enable the GNOME Desktop Environment.
      displayManager.gdm.enable = true;
      desktopManager.gnome.enable = true;

      # Configure keymap in X11
      xkb = {
        layout = "us, ru";
        variant = "";
      };

      # Enable automatic login for the user.
      displayManager.autoLogin = {
        enable = true;
        user = "sas";
      };

      # Enable nvidia drivers
      videoDrivers = [ "nvidia" ]; # or "nvidiaLegacy470 etc.
    };
    printing.enable = true;
    pipewire = {
      enable = true;
      alsa = {
        enable = true;
        support32Bit = true;
      };
      pulse.enable = true;
    };

    flatpak = {
      enable = true;
      packages = [
        "net.xmind.XMind"
      ];
    };
  };

  # Enable sound with pipewire.
  sound.enable = true;
  security.rtkit.enable = true;

  users.users.sas = {
    isNormalUser = true;
    description = "sas";
    extraGroups = [ "networkmanager" "wheel" "docker" ];
  };

  # Workaround for GNOME autologin: https://github.com/NixOS/nixpkgs/issues/103746#issuecomment-945091229
  systemd.services = {
    "getty@tty1".enable = false;
    "autovt@tty1".enable = false;
  };

  # What i added starts here.

  boot.kernelPackages = pkgs.linuxPackages_6_8;

  # Allow unfree packages
  nixpkgs.config = {
    allowUnfree = true;
    nvidia.acceptLicense = true;
  };

  hardware = {
    pulseaudio.enable = false;

    # Enable OpenGL
    opengl = {
      enable = true;
      driSupport = true;
      driSupport32Bit = true;
    };
    nvidia = {
      modesetting.enable = true;
      powerManagement = {
        enable = false;
        finegrained = false;
      };
      open = false;
      nvidiaSettings = true;
      package = config.boot.kernelPackages.nvidiaPackages.stable;
      prime = {
        intelBusId = "PCI:0:2:0";
        nvidiaBusId = "PCI:1:0:0";
      };
    };
  };

  programs.steam.enable = true;

  virtualisation.docker.enable = true;

  environment.systemPackages = with pkgs; [
    neovim # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default.
    git
    neofetch
    docker
    nodejs_20
    python3
    telegram-desktop
    google-chrome
    opera # Browser with VPN
    vscode-fhs
    steam
    lutris
    mangohud
    wine-wayland
    qbittorrent
    appimage-run
    lshw
    bleachbit
    baobab
    reaper
    obsidian
    rclone
    unzip
    zulu8
    zulu17
    vlc
    bottles
    rustdesk-flutter
    (pkgs.callPackage (import ./bun-baseline.nix) { })
    obs-studio
    rustup
    minetest
    gamemode
    steamPackages.steamcmd
    godot_4
    nixpkgs-fmt
    libreoffice
    sqlite
    gcc
    thunderbird
  ];

  fonts.packages = with pkgs; [
    fira-code-nerdfont
  ];

  nix = {
  optimise = {
    automatic = true;
    dates = [ "03:45" ];
  };
    settings.experimental-features = [ "nix-command" "flakes" ];
  };
  system.stateVersion = "23.05";

}
