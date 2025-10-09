{pkgs, ...}: let
  startupScript = pkgs.pkgs.writeShellScriptBin "start" ''
    sleep 5

    waybar &
    swww init &

    sleep 1

    swww img "~/Pictures/wallpaper.png"
  '';
in {
  imports = [
    ./programs
    ./services.nix
    ./packages.nix
    ./binds.nix
    ./looks.nix
  ];

  wayland.windowManager.hyprland = {
    enable = true;
    xwayland.enable = true;
    settings = {
      "debug:disable_logs" = "false";
      monitor = [
        ", preferred, auto, 1"
      ];
      input = {
        kb_layout = "us, ru";
        kb_options = "grp:win_space_toggle";
      };
      gestures = {
        workspace_swipe = true;
        workspace_swipe_fingers = 3;
      };
      exec-once = ''${startupScript}/bin/start'';
    };
  };
}
