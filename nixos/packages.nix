{
  pkgs,
  pkgs-stable,
  ...
}: {
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
      # media
      mpv
      stremio # movies & anime & shows
      ani-cli # anime in terminal
      spotube
      vlc
      # messaging
      element-desktop
      ayugram-desktop
      vesktop
      signal-desktop
      # coding
      wl-clipboard # neovim requiring this
      vscodium-fhs
      zed-editor
      code-cursor
      wget
      podman-compose
      waydroid
      ghostty
      # browsers
      surf
      # notes related
      rclone # sync tool
      # games related
      lutris
      mangohud
      wineWowPackages.stable
      wineWowPackages.fonts
      steamcmd
      piper # some shit for mouse
      libratbag # some shit for mouse
      protonup-qt
      antimicrox
      protontricks
      pkg-config
      minetestclient
      # unsorted
      peazip
      qbittorrent-enhanced
      unzip
      rustdesk-flutter # remote desktop
      sweet
      bitwarden # password manager
      winetricks
      devenv
      obsidian
      hardinfo2
    ])
    ++ (with pkgs-stable; [
      hello
    ]);
}
