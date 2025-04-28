{ config, pkgs-unstable, ... }:

{
  home = {
    username = "sas";
    homeDirectory = "/home/sas";
    stateVersion = "23.11";
    sessionVariables = {
      XDG_CONFIG_HOME = "$HOME/.config";
      NIXOS_OZONE_WL = "1";
    };
    # packages = with pkgs; [];
  };
  programs.home-manager.enable = true;
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
    kitty = {
      enable = true;
    };
  };
  wayland.windowManager.hyprland = {
    enable = true;
    settings = {
      "$mod" = "SUPER";
      bind =
        [
          "$mod, F, exec, librewolf"
          ", Print, exec, grimblast copy area"
        ]
        ++ (
          # workspaces
          # binds $mod + [shift +] {1..9} to [move to] workspace {1..9}
          builtins.concatLists (builtins.genList (i:
              let ws = i + 1;
              in [
                "$mod, code:1${toString i}, workspace, ${toString ws}"
                "$mod SHIFT, code:1${toString i}, movetoworkspace, ${toString ws}"
              ]
            )
            9)
        );
    };
  };
}
