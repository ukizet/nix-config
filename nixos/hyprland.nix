{ pkgs, ... }:
let
 startupScript = pkgs.writeShellScriptBin "start" ''
   waybar & 
   swww init &

   sleep 1
   swww img /home/sas/Pictures/dsr.jpg
 '';
in
{
  programs = {
    kitty.enable = true;
    waybar = {
      enable = true;
    };
    rofi.enable = true;
  };
  services = {
    dunst.enable = true;
    swww.enable = true;
  };
  wayland.windowManager.hyprland = {
    enable = true;
    xwayland.enable = true;
    settings = {
      "debug:disable_logs" = "false";
      "$mod" = "SUPER";
      "$browser" = "librewolf";
      "$terminal" = "kitty";
      "$runner" = "rofi";
      "$explorer" = "dolphin";
      monitor = [
        "DP-1, 1920x1080@60, 0x0, 1"
        "VGA-1, 1920x1080@60, 0x0, 1"
      ];
      bind =
        [
          "$mod ALT, h, movefocus, l"
          "$mod ALT, l, movefocus, r"
          "$mod ALT, k, movefocus, u"
          "$mod ALT, j, movefocus, d"
          "$mod, B, exec, $browser"
          "$mod, T, exec, $terminal"
          "$mod, E, exec, $explorer"
          "$mod, S, exec, $runner -show drun -show-icons"
          "$mod, C, killactive"
          "$mod, M, exit"
          "$mod, V, togglefloating"
          "$mod, P, pseudo"
          "$mod, J, togglesplit"
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
      bindm = [
        "$mod, mouse:272, movewindow"
        "$mod, mouse:273, resizewindow"
        "$mod ALT, mouse:272, resizewindow"
      ];
      exec-once = ''${startupScript}/bin/start'';
    };
  };
}
