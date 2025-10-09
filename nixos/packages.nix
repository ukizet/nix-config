{
  pkgs,
  pkgs-stable,
  inputs,
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
      mpv # media player
      stremio # movies & anime & shows
      ani-cli # anime in terminal
      spotube
      vlc # media player
      pqiv # image viewer
      # messaging
      element-desktop
      ayugram-desktop
      vesktop
      signal-desktop
      tmpmail
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
      devenv # dev environment
      obsidian # notes
      hardinfo2
      astroterm # stars
      inputs.yt-x.packages."${system}".default # youtube in terminal
      duf # disk usage util
    ])
    ++ (with pkgs-stable; [
      hello
    ]);
}
