{ pkgs, ... }:

{
  home = {
    username = "sas";
    homeDirectory = "/home/sas";
    stateVersion = "23.11";
    sessionVariables = {
      XDG_CONFIG_HOME = "$HOME/.config";
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
      enableZshIntegration = true;
      # nix-direnv.enable = true;
    };
    zsh = {
      enable = true;
      enableCompletion = true;
      autosuggestion.enable = true;
      syntaxHighlighting.enable = true;
      shellAliases = {
        rebuild = "cd ~/nix-config &&
          sudo nixos-rebuild switch --flake .
        ";
        rebuildboot = "cd ~/nix-config && sudo nixos-rebuild boot --flake .";
        upgraderebuildboot = "
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
        rclientbisync = "
          cd ~/Documents/Vault &&
          gcam \"date +'%Y-%m-%d %H:%M:%S'\" &&
          gpush &&
          ~/Documents/repos/rclone_scripts/rclient.sh bisync
        ";
        sw = "nh os switch -- --impure";
        swu = "nh os switch -u -- --impure";
        dv = "devenv shell";
      };
      oh-my-zsh = {
        enable = true;
        theme = "agnoster";
      };
      initExtra = "tmux a || tmux";
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
  };
}
