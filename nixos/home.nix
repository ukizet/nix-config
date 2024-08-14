{ pkgs, ... }:

{
  home = {
    username = "sas";
    homeDirectory = "/home/sas";
    stateVersion = "23.11";
  };
  home.packages = with pkgs.gnomeExtensions; [
    # may be part of url, like here:
    # https://extensions.gnome.org/extension/1723/wintile-windows-10-window-tiling-for-gnome/
    gtile
    appindicator
    clipboard-indicator
  ];
  dconf = {
    enable = true;
    settings = {
      "org/gnome/desktop/interface".color-scheme = "prefer-dark";
      "org/gnome/shell" = {
        disable-user-extensions = false;
        # `gnome-extensions list` for a list
        enabled-extensions = [
          "gTile@vibou"
          "appindicatorsupport@rgcjonas.gmail.com"
          "clipboard-indicator@tudmotu.com"
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
    bash = {
      enable = true;
      shellAliases = {
        rebuild = "cd ~/nix-config && sudo nixos-rebuild switch --flake .";
        rebuildboot = "cd ~/nix-config && sudo nixos-rebuild boot --flake .";
        upgraderebuild = "
          cd ~/mysystem/ &&
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
