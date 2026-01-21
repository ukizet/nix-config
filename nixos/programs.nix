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
    zsh.enable = true;
    gpu-screen-recorder.enable = true;
  };
}
