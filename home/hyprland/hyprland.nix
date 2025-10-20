{pkgs, ...}: let
  startupScript = pkgs.pkgs.writeShellScriptBin "start" ''
    sleep 1

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
        sensitivity = 0;
        accel_profile = "flat";
        follow_mouse = 1;
        touchpad.disable_while_typing = false;
      };
      gestures = {
        workspace_swipe = true;
        workspace_swipe_fingers = 3;
      };
      exec-once = ''${startupScript}/bin/start'';
    };
  };
}
