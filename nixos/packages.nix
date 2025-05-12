{ pkgs, pkgs-stable, ... }:

{
  environment.systemPackages = 
    (with pkgs; [
      # nixos related
      nixfmt-rfc-style
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
      mpv
      stremio # movies & anime & shows
      reaper # daw
      zrythm # daw
      lmms # open source daw
      yabridge
      yabridgectl
      alsa-lib
      clap
      samplv1
      parabolic # download media from youtube
      localsend # files sharing
      shortwave # internet radio
      blender-hip # blender with amd support
      ani-cli # anime in terminal
      # messaging
      element-desktop
      telegram-desktop
      paper-plane
      kotatogram-desktop
      ayugram-desktop
      vesktop
      signal-desktop
      # coding
      wl-clipboard # neovim requiring this
      vscodium-fhs
      wget
      podman-compose
      android-studio
      waydroid
      # browsers
      librewolf
      # notes related
      obsidian
      rclone # sync tool
      qownnotes
      # games related
      lutris
      mangohud
      wineWowPackages.stagingFull
      wineasio
      steamcmd
      piper
      libratbag
      protonup-qt
      antimicrox
      protontricks
      pkg-config
      minetestclient
      jdk23
      # hyprland
      libnotify
      # unsorted
      peazip
      gnome-boxes
      qbittorrent-enhanced
      gpu-screen-recorder
      unzip
      rustdesk-flutter # remote desktop
      kdePackages.filelight
      evolution
      sweet
      bitwarden # password manager
      jan
      lmstudio
      winetricks
    ])

    ++ 

    (with pkgs-stable; [
      hello
    ]);
}
