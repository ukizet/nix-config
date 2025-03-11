{ config, pkgs, inputs, ... }:

let
  unstable = inputs.unstable.legacyPackages.x86_64-linux;
in
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
    nameservers = [
      "45.90.28.0#25611f.dns.nextdns.io"
      "2a07:a8c0::#25611f.dns.nextdns.io"
      "45.90.30.0#25611f.dns.nextdns.io"
      "2a07:a8c1::#25611f.dns.nextdns.io"
    ];
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
    desktopManager = {
        plasma6.enable = true;
      };
    displayManager = {
        sddm.enable = true;
      };
    xserver = {
      enable = true;
      # Enable the GNOME Desktop Environment.
      videoDrivers = [ "amdgpu" ];
    };
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
        "com.ktechpit.torrhunt"
        "org.qbittorrent.qBittorrent"
        "org.gnome.Boxes"
        "com.usebottles.bottles"
        "com.authormore.penpotdesktop"
        "io.frama.tractor.carburetor"
        "io.github.zen_browser.zen"
        "com.jeffser.Alpaca"
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
    tmpfiles = {
      rules = [
        "L+    /opt/rocm/hip   -    -    -     -    ${pkgs.rocmPackages.clr}"
      ];
    };
  };

  nixpkgs.config = {
    allowUnfree = true;
  };

  nixpkgs.config.permittedInsecurePackages = [
    "electron-27.3.11"
  ];

  hardware = {
    pulseaudio.enable = false;

    # Enable OpenGL
    opengl = {
      enable = true;
      driSupport = true;
      driSupport32Bit = true;
      extraPackages = with pkgs; [
        rocmPackages.clr.icd
        amdvlk
      ];
      extraPackages32 = with pkgs; [
        driversi686Linux.amdvlk
      ];
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

  virtualisation = {
    containers.enable = true;
    docker.enable = true;
    podman = {
      enable = true;

      # Required for containers under podman-compose to be able to talk to each other.
      defaultNetwork.settings.dns_enabled = true;
    };
  };

  environment = {
    variables = {
      ROC_ENABLE_PRE_VEGA = "1";
    };
    sessionVariables.NIXOS_OZONE_WL = "1";
    systemPackages = with pkgs; [
      unzip
      rustdesk-flutter # remote desktop

      bitwarden # password manager
      # nixos related
      nixpkgs-fmt # nix code formatter
      appimage-run # workaround for appimages
      # computer info
      fastfetch # os info
      lshw # extended hardware info
      resources
      htop
      xorg.xwininfo
      clinfo
      mesa
      mesa-demos
      wayland-utils
      vulkan-tools
      # media
      vlc # music & video player
      stremio # movies & anime & shows
      reaper # daw
      zrythm # daw
      lmms # open source daw
      ardour # open source daw
      yabridge # bridge to make vst plugins installed in wine instance accesable in linux daws
      yabridgectl
      alsa-lib
      clap
      samplv1
      parabolic # download media from youtube
      localsend # files sharing
      weather
      shortwave # internet radio
      blender-hip
      # messaging
      element-desktop
      telegram-desktop
      discord
      # coding
      neovim # Do not forget to add an editor to edit configuration.nix!
      wl-clipboard # neovim requiring this
      vscode-fhs
      vscodium-fhs
      unstable.zed-editor
      xdotool
      unixtools.xxd
      yad
      wget
      python3
      podman-compose
      bun # javascript thing (runtime)
      # browsers
      # notes related
      obsidian
      rclone
      # games related
      lutris
      mangohud
      wineWowPackages.waylandFull
      winetricks
      wineasio
      steamPackages.steamcmd
      jdk
      piper
      libratbag
      protonup-qt
      antimicrox
      protontricks
      pkg-config
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
