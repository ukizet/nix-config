{pkgs, ...}: {
  wayland.windowManager.hyprland.settings = {
    general = {
      no_border_on_floating = "true";
      gaps_in = 3;
      gaps_out = 10;
    };
    decoration = {
      rounding = 8;
      active_opacity = 0.8;
      inactive_opacity = 0.5;
    };
  };
}
