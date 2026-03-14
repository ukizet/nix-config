{pkgs, ...}: {
  imports = [
    ./nvf.nix
  ];
  programs = {
    steam = {
      enable = true;
      gamescopeSession.enable = true;
      protontricks.enable = true;
      remotePlay.openFirewall = true;
      extraCompatPackages = with pkgs; [
        proton-ge-bin
      ];
      extraPackages = with pkgs; [
        steamtinkerlaunch
      ];
    };
    gamemode.enable = true;
    nh = {
      enable = true;
      # clean.enable = true;
      clean.extraArgs = "--keep-since 4d --keep 3";
      flake = "/home/sas/nix-config";
    };
    zsh = {
      enable = true;
      autosuggestions.enable = true;
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
        ec = "cd ~/.config && nvim";
        lam = "llama-server -m ~/models/Qwen2.5-Coder-3B-Instruct-Q4_K_M.gguf -dev Vulkan0,Vulkan1 -ngl all --flash-attn on --cache-type-k q4_0 --cache-type-v q4_0 -np 1 -c 65536 --jinja -t 4 -b 256 -ub 128 --host 127.0.0.1 --port 8033";
        zerod = "zeroclaw daemon";
      };
      ohMyZsh = {
        enable = true;
        theme = "agnoster";
      };
    };
    gpu-screen-recorder.enable = true;
    yazi = {
      enable = true;
      settings.yazi = {
        show_hidden = true;
      };
    };
    git = {
      enable = true;
      config = {
        init = {
          defaultBranch = "development";
        };
        user = {
          email = "ukikatuki@gmail.com";
          name = "ukizet";
        };
        url = {
          "https://github.com/" = {
            insteadOf = [
              "gh:"
              "github:"
            ];
          };
        };
      };
    };
    npm.enable = true;
    tmux = {
      enable = true;
      baseIndex = 1;
      clock24 = true;
      historyLimit = 5000;
      keyMode = "vi";
      extraConfig = "set -g renumber-windows on";
    };
  };
}
