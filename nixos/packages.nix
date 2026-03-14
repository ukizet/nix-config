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
      appimage-run # workaround for appimages
      # computer info
      fastfetch # os info
      lshw # extended hardware info
      resources
      htop
      xwininfo
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
      wineWow64Packages.stable
      # wineWow64Packages.fonts
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
      hledger
      hledger-ui
      alacritty
      alacritty-theme
      noctalia-shell
      mako
      polkit_gnome
      nil
      alejandra
      swaylock
      zellij
      dwarf-fortress
      openmw
      rqbit
      blanket
      inputs.zen-browser.packages.${pkgs.stdenv.hostPlatform.system}.default
      # inputs.zeroclaw.packages.x86_64-linux.default
      # openclaw
      zeroclaw
      nodejs_25
      python315
      llama-cpp-vulkan
      nvtopPackages.full
      btop
      # swayidle
      # rmpc # TUI music player
    ])
    ++ (with pkgs-stable; [
      # hello
      # lutris
      # gamescope
      # android-studio-full
    ]);
}
