{pkgs, ...}: let
  startupScript = pkgs.pkgs.writeShellScriptBin "start" ''
    sleep 5

    waybar &
    swww init &

    sleep 1

  '';
in {
  imports = [
    ./programs
    ./services.nix
    ./packages.nix
    ./binds.nix
  ];

  wayland.windowManager.hyprland = {
    enable = true;
    xwayland.enable = true;
    settings = {
      "debug:disable_logs" = "false";
      monitor = [
        ", preferred, auto, 1"
      ];
      exec-once = ''${startupScript}/bin/start'';
    };
  };
}
