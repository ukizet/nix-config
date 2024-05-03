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
    # Enable automatic login for the user.
    displayManager.autoLogin = {
      enable = true;
      user = "sas";
    };

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
      jack.enable = true;
    };

    flatpak = {
      enable = true;
      packages = [
        "net.xmind.XMind"
        "com.github.tchx84.Flatseal"
        "io.github.peazip.PeaZip"
        "org.qbittorrent.qBittorrent"
        "org.telegram.desktop"
        "org.kde.kdenlive"
        "com.dec05eba.gpu_screen_recorder"
        "com.obsproject.Studio"
        "com.usebottles.bottles"
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
      	sync.enable = true;
        intelBusId = "PCI:0:2:0";
        nvidiaBusId = "PCI:1:0:0";
      };
    };
  };

  programs = {
		steam = {
			enable = true;
			gamescopeSession.enable = true;
		};
		gamemode.enable = true;
  };

  virtualisation.docker.enable = true;

  environment.systemPackages = with pkgs; [
    neovim # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default.
    neofetch
    nodejs_20
    python3
    google-chrome
    opera # Browser with VPN
    vscode-fhs
    lutris
    mangohud
    wine-wayland
    appimage-run
    lshw
    bleachbit
    reaper
    obsidian
    rclone
    unzip
    zulu17
    vlc
    rustdesk-flutter
    (pkgs.callPackage (import ./bun-baseline.nix) { })
    obs-studio
    rustup
    minetest
    steamPackages.steamcmd
    godot_4
    nixpkgs-fmt
    libreoffice
    sqlite
    gcc
    thunderbird
    stremio
    pkgsi686Linux.gperftools
    logseq
    wl-clipboard
  ];

  environment.sessionVariables.NIXOS_OZONE_WL = "1";

  fonts.packages = with pkgs; [
    fira-code-nerdfont
  ];

  nix = {
    optimise = {
      automatic = true;
      dates = [ "weekly" ];
    };
    gc = {
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than 30d";
    };
    settings.experimental-features = [ "nix-command" "flakes" ];
  };
  system.stateVersion = "23.05";

}
