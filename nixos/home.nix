{ pkgs, ... }:

{
  home = {
    username = "sas";
    homeDirectory = "/home/sas";
    stateVersion = "23.11";
    packages = with pkgs; [
      gnomeExtensions.appindicator
    ];
    sessionVariables = {
      XDG_CONFIG_HOME = "$HOME/.config";
    };
    file.".config/autostart/telegram-desktop.desktop".text = ''
      [Desktop Entry]
      Type=Application
      Exec=${pkgs.telegram-desktop}/bin/telegram-desktop
      Hidden=false
      NoDisplay=false
      X-GNOME-Autostart-enabled=true
      Name=Telegram
      Comment=Launch Telegram on startup
    '';
    file.".config/autostart/qbittorrent.desktop".text = ''
      [Desktop Entry]
      Type=Application
      Exec=${pkgs.qbittorrent}/bin/qbittorrent
      Hidden=false
      NoDisplay=false
      X-GNOME-Autostart-enabled=true
      Name=qBittorrent
      Comment=Launch qBittorrent minimized to tray
    '';
    file.".config/autostart/steam.desktop".text = ''
      [Desktop Entry]
      Type=Application
      Exec=${pkgs.steam}/bin/steam
      Hidden=false
      NoDisplay=false
      X-GNOME-Autostart-enabled=true
      Name=Steam
      Comment=Launch Steam on startup
    '';
  };
  dconf = {
    enable = true;
    settings = {
      "org/gnome/desktop/interface".color-scheme = "prefer-dark";
      "org/gnome/shell" = {
        disable-user-extensions = false;
        # `gnome-extensions list` for a list
        enabled-extensions = [
          "appindicatorsupport@rgcjonas.gmail.com"
          "apps-menu@gnome-shell-extensions.gcampax.github.com"
          "system-monitor@gnome-shell-extensions.gcampax.github.com"
        ];
      };
    };

  };
  programs = {
    git = {
      enable = true;
      userName = "ukizet";
      userEmail = "ukikatuki@gmail.com";
    };
    direnv = {
      enable = true;
      enableBashIntegration = true; # see note on other shells below
      nix-direnv.enable = true;
    };
    bash = {
      enable = true;
      bashrcExtra = "eval \"$(direnv hook bash)\"";
      shellAliases = {
        rebuild = "cd ~/nix-config &&
          sudo nixos-rebuild switch --flake .
        ";
        rebuildboot = "cd ~/nix-config && sudo nixos-rebuild boot --flake .";
        upgraderebuild = "
          cd ~/nix-config/ &&
          nix flake update &&
          sudo nixos-rebuild boot --flake .
        ";
        nixclean = "
          sudo nix-collect-garbage -d &&
          sudo nix-store --gc &&
          sudo nix-store --optimise &&
          nix-collect-garbage -d
        ";
        gs = "git status";
        gcam = "git commit -am";
        gpush = "git push";
        gpull = "git pull";
        gad = "git add .";
        scmd = "steamcmd";
        vim = "nvim";
        rclientbisync = "~/Documents/repos/rclone_scripts/rclient.sh bisync";
      };
    };
  };
}
