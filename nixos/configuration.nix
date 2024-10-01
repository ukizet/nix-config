{ config, pkgs, ... }:

{
  imports =
    [
      ./hardware-configuration.nix
    ];

  boot = {
    loader = {
      systemd-boot.enable = true;
      efi.canTouchEfiVariables = true;
    };
    initrd.kernelModules = [ "amdgpu" ];
  };

  networking = {
    hostName = "nixos"; # Define your hostname.
    networkmanager.enable = true;
  };

  time.timeZone = "Europe/Kyiv";

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
      enable = true;
      # Enable the GNOME Desktop Environment.
      displayManager = {
        gdm = {
          enable = true;
          wayland = true;
        };
      };
      desktopManager.gnome.enable = true;
      videoDrivers = [ "amdgpu" ];
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
      update.auto = {
        enable = true;
        onCalendar = "monthly"; # Default value
      };
      overrides = {
        global = {
          # Force Wayland by default
          Context.sockets = [ "wayland" "!x11" "!fallback-x11" ];

          Environment = {
            # Fix un-themed cursor in some Wayland apps
            XCURSOR_PATH = "/run/host/user-share/icons:/run/host/share/icons";

            # Force correct theme for some GTK apps
            GTK_THEME = "Adwaita:dark";
          };
        };
      };
      packages = [
        "com.github.tchx84.Flatseal"
        "io.github.peazip.PeaZip"
        "com.dec05eba.gpu_screen_recorder"
        "io.github.giantpinkrobots.flatsweep"
        "org.kde.kdenlive"
        "com.bitwig.BitwigStudio"
        "net.waterfox.waterfox"
        "com.obsproject.Studio"
        "com.jeffser.Alpaca"
        "com.github.KRTirtho.Spotube"
      ];
    };
  };

  security = {
    rtkit.enable = false;
    pam.loginLimits = [
      {
        domain = "@audio";
        item = "rtprio";
        type = "-";
        value = "95";
      }
      {
        domain = "@audio";
        item = "memlock";
        type = "-";
        value = "unlimited";
      }
    ];
  };

  users.users.sas = {
    isNormalUser = true;
    description = "sas";
    extraGroups = [ "networkmanager" "wheel" "docker" "realtime" "audio" "jackuser" ];
  };

  systemd = {
    services = {
      "getty@tty1".enable = false;
      "autovt@tty1".enable = false;
      "ratbagd".enable = true;
    };
    user.services = {
      autorn = {
        description = "...";
        serviceConfig.PassEnvironment = "DISPLAY";
        script = ''
          qbittorrent
        '';
        wantedBy = [ "multi-user.target" ]; # starts after login
      };
    };
  };

  nixpkgs.config = {
    allowUnfree = true;
  };

  hardware = {
    pulseaudio.enable = false;

    # Enable OpenGL
    opengl = {
      enable = true;
      driSupport = true;
      driSupport32Bit = true;
    };
    bluetooth = {
      enable = true;
      powerOnBoot = true;
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

  environment = {
    sessionVariables.NIXOS_OZONE_WL = "1";
    systemPackages = with pkgs; [
      neovim # Do not forget to add an editor to edit configuration.nix!
      wl-clipboard # neovim requiring this
      unzip
      rustdesk-flutter # remote desktop
      bun
      bitwarden # password manager
      localsend # files sharing
      telegram-desktop
      bottles
      ollama
      # nixos related
      nixpkgs-fmt # nix code formatter
      appimage-run # workaround for appimages
      # computer info
      neofetch # os info
      lshw # extended hardware info
      resources
      htop
      # media
      vlc # music & video player
      stremio # movies & anime & shows
      reaper
      lmms
      ardour
      qbittorrent
      yabridge
      yabridgectl
      alsa-lib
      clap
      winetricks
      samplv1
      # related to languages
      nodejs_20
      python3
      rustup
      gcc
      sqlite
      # browsers
      google-chrome
      brave
      firefox
      # coding
      vscode-fhs
      vscodium-fhs
      zed-editor
      # notes related
      logseq
      obsidian
      rclone
      # games related
      lutris
      mangohud
      wine64
      wineasio
      steamPackages.steamcmd
      jdk
      piper
      libratbag
      protonup-qt
    ];
  };

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
