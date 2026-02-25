{
  pkgs,
  pkgs-stable,
  inputs,
  ...
}: {
  environment.systemPackages =
    (with pkgs; [
      # dwm
      # dmenu
      # dmenu-bluetooth
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
      # stremio # movies & anime & shows. And.. now it's uses old qtwebengine.. so I can't use it
      ani-cli # anime in terminal
      spotube
      vlc # media player
      pqiv # image viewer
      # messaging
      element-desktop
      ayugram-desktop # telegram client
      vesktop # discord client
      signal-desktop
      tmpmail
      # coding
      wl-clipboard # neovim requiring this
      vscodium-fhs
      zed-editor
      wget
      podman-compose
      waydroid
      # browsers
      # notes related
      rclone # sync tool
      # games related
      mangohud
      # wineWowPackages.stable
      wineWowPackages.fonts
      steamcmd
      piper # some shit for mouse
      libratbag # some shit for mouse
      protonup-qt
      antimicrox
      protontricks
      pkg-config
      # unsorted
      peazip
      # qbittorrent-enhanced
      unzip
      rustdesk-flutter # remote desktop
      sweet
      bitwarden-desktop # password manager
      winetricks
      devenv # dev environment
      obsidian # notes
      hardinfo2
      astroterm # stars
      inputs.yt-x.packages."${system}".default # youtube in terminal
      duf # disk usage util
      # flutter
      baobab
      noctalia-shell
    ])
    ++ (with pkgs-stable; [
      # hello
      # lutris
      # gamescope
      # android-studio-full
    ]);
}
