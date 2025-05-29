{
  config,
  pkgs,
  pkgs-stable,
  inputs,
  ...
}: {
  imports = [
    ./hardware-configuration.nix
    ./flatpak.nix
    ./programs.nix
    ./packages.nix
    # ./nextcloud.nix
  ];

  boot = {
    loader = {
      systemd-boot.enable = true;
      efi.canTouchEfiVariables = true;
    };
    initrd.kernelModules = ["amdgpu"];
    kernelPackages = pkgs.linuxPackages_latest;
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
    pulseaudio.enable = false;
    desktopManager = {
      plasma6.enable = true;
    };
    displayManager = {
      sddm = {
        enable = true;
        wayland.enable = true;
      };
    };
    xserver = {
      enable = true;
      videoDrivers = ["amdgpu"];
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

  systemd = {
    tmpfiles.rules = [
      "L+    /opt/rocm/hip   -    -    -     -    ${pkgs.rocmPackages.clr}"
    ];
    services = {
      "getty@tty1".enable = false;
      "autovt@tty1".enable = false;
      "ratbagd".enable = true;
    };
  };

  hardware = {
    graphics = {
      enable = true;
      enable32Bit = true;
      extraPackages = with pkgs; [
        rocmPackages.clr.icd
        amdvlk
        # ocl-icd
      ];
      extraPackages32 = with pkgs; [
        driversi686Linux.amdvlk
      ];
    };
    amdgpu.opencl.enable = true;
    bluetooth = {
      enable = true;
      powerOnBoot = true;
    };
  };

  virtualisation = {
    containers.enable = true;
    podman = {
      enable = true;

      # Required for containers under podman-compose to be able to talk to each other.
      defaultNetwork.settings.dns_enabled = true;
    };
    waydroid.enable = true;
  };

  environment = {
    variables = {
      # enable opencl on polaris
      ROC_ENABLE_PRE_VEGA = "1";
      AMD_VULKAN_ICD = "RADV";
    };
    sessionVariables = {
      NIXOS_OZONE_WL = "1";
      NH_FLAKE = "/home/sas/nix-config";
      FLAKE = "/home/sas/nix-config";
      # WINEPREFIX = "not defined. Install ableton somewhere first";
    };
  };

  fonts.packages = with pkgs; [
    nerd-fonts.fira-code
  ];

  nix = {
    optimise = {
      automatic = true;
      dates = ["weekly"];
    };
    settings.experimental-features = [
      "nix-command"
      "flakes"
    ];
    extraOptions = ''
      trusted-users = root sas
    '';
  };
  system.stateVersion = "23.05";
}
