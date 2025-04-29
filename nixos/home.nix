{ config, pkgs, ... }:
{
  imports = [
    ./hyprland.nix
  ];

  home = {
    username = "sas";
    homeDirectory = "/home/sas";
    stateVersion = "23.11";
    sessionVariables = {
      XDG_CONFIG_HOME = "$HOME/.config";
    };
    # packages = with pkgs; [];
  };
  programs = {
    git = {
      enable = true;
      userName = "ukizet";
      userEmail = "ukikatuki@gmail.com";
    };
    direnv = {
      enable = true;
      enableZshIntegration = true;
    };
    zsh = {
      enable = true;
      enableCompletion = true;
      autosuggestion.enable = true;
      syntaxHighlighting.enable = true;
      shellAliases = {
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
        rclientbisync = "
          cd ~/Documents/Vault &&
          gcam \"date +'%Y-%m-%d %H:%M:%S'\" &&
          gpush &&
          ~/Documents/repos/rclone_scripts/rclient.sh bisync
        ";
        hm = "home-manager switch --flake $FLAKE";
        sw = "nh os switch -- --impure";
        swup = "nh os boot -u -- --impure";
        dv = "devenv shell";
        ys = "yabridgectl sync";
        en = "cd ~/nix-config && nvim";
      };
      oh-my-zsh = {
        enable = true;
        theme = "agnoster";
      };
      initContent = "tmux a || tmux";
    };
    alacritty = {
      enable = true;
    };
    ghostty = {
      enable = true;
      enableZshIntegration = true;
    };
    tmux = {
      enable = true;
      keyMode = "vi";
      disableConfirmationPrompt = true;
    };
    obs-studio = {
      enable = true;
    };
  };
}
