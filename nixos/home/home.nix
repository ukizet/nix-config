{
  config,
  pkgs,
  ...
}: {
  imports = [
    ./hyprland
    # ./wineasio.nix
  ];

  home = {
    username = "sas";
    homeDirectory = "/home/sas";
    stateVersion = "25.05";
  };
  xdg.portal = {
    enable = true;
    extraPortals = [pkgs.xdg-desktop-portal-gtk];
  };
  programs = {
    librewolf = {
      enable = true;
      settings = {
        "privacy.resistFingerprinting" = false;
      };
    };
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
          ~/Documents/repos/rclone_scripts/rclient.sh bisync
        ";
        hm = "home-manager switch --flake $FLAKE";
        sw = "nh os switch";
        oldsw = "
          cd ~/nix-config/ &&
          sudo nixos-rebuild boot --flake .
        ";
        oldup = "
          cd ~/nix-config/ &&
          nix flake update &&
          sudo nixos-rebuild boot --flake .
        ";
        up = "nh os boot -u";
        dv = "devenv shell";
        ys = "yabridgectl sync --prune";
        en = "cd ~/nix-config && nvim";
      };
      oh-my-zsh = {
        enable = true;
        theme = "agnoster";
      };
      initContent = ''
        bindkey -v
      '';
    };
    ghostty = {
      enable = true;
      enableZshIntegration = true;
      installVimSyntax = true;
      settings = {
        theme = "catppuccin-mocha";
        font-size = 18;
      };
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
