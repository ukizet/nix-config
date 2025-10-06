{pkgs, ...}: {
  wayland.windowManager.hyprland.settings = {
    "$mod" = "SUPER";
    "$browser" = "librewolf";
    "$terminal" = "ghostty";
    "$runner" = "rofi";
    "$explorer" = "dolphin";
    "$network" = "ghostty -e nmtui";
    "$bar" = "pkill waybar; waybar";
    "$anime" = "ghostty -e ani-cli";
    bind =
      [
        "$mod ALT, h, movefocus, l"
        "$mod ALT, l, movefocus, r"
        "$mod ALT, k, movefocus, u"
        "$mod ALT, j, movefocus, d"
        "$mod, B, exec, $browser"
        "$mod ALT, B, exec, $bar"
        "$mod, T, exec, $terminal"
        "$mod, E, exec, $explorer"
        "$mod, S, exec, $runner -show drun -show-icons"
        "$mod, N, exec, $network"
        "$mod, C, killactive"
        "$mod, M, exit"
        "$mod, V, togglefloating"
        "$mod, P, pseudo"
        "$mod, J, togglesplit"
        "$mod, A, exec, $anime"
        ",XF86AudioMute, exec, pactl set-sink-mute @DEFAULT_SINK@ toggle"
        ",XF86AudioLowerVolume, exec, pactl set-sink-volume @DEFAULT_SINK@ -5%"
        ",XF86AudioRaiseVolume, exec, pactl set-sink-volume @DEFAULT_SINK@ +5%"
        ",XF86MonBrightnessDown, exec, brightnessctl set 5%-"
        ",XF86MonBrightnessUp, exec, brightnessctl set +5%"
      ]
      ++ (
        builtins.concatLists (builtins.genList (
            i: let
              ws = i + 1;
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
  };
}
