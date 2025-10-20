{
  config,
  pkgs,
  ...
}: {
  programs.zsh = {
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
}
