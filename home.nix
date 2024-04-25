{
  home = {
    username = "sas";
    homeDirectory = "/home/sas";
    stateVersion = "23.11";
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
        rebuild = "sudo nixos-rebuild switch --flake ~/mysystem/";
        upgraderebuild = "
          cd ~/mysystem/ &&
          nix flake update &&
          sudo nixos-rebuild switch --flake .
        ";
        nixclean="
          sudo nix-collect-garbage -d &&
          nix-collect-garbage -d &&
          nix-store --optimise &&
          nix-store --gc
        ";
        gs="git status";
        gcam="git commit -am";
        gp="git push";
        gad="git add .";
        scmd="
          steamcmd <<EOF
          login anonymous
          EOF
        "; 
      };
    };
  };
}
