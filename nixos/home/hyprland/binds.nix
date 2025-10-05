{pkgs, ...}: {
  wayland.windowManager.hyprland.settings = {
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
        "$mod, N, exec, $network"
        "$mod, C, killactive"
        "$mod, M, exit"
        "$mod, V, togglefloating"
        "$mod, P, pseudo"
        "$mod, J, togglesplit"
        ",XF86AudioMute, exec, pactl set-sink-mute @DEFAULT_SINK@ toggle"
        ",XF86AudioLowerVolume, exec, pactl set-sink-volume @DEFAULT_SINK@ -5%"
        ",XF86AudioRaiseVolume, exec, pactl set-sink-volume @DEFAULT_SINK@ +5%"
        ",XF86MonBrightnessDown, exec, brightnessctl set 5%-"
        ",XF86MonBrightnessUp, exec, brightnessctl set +5%"
      ]
      ++ (
        # workspaces
        # binds $mod + [shift +] {1..9} to [move to] workspace {1..9}
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
