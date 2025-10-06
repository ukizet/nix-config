{pkgs, ...}: {
  imports = [
    ./modules.nix
  ];
  programs.waybar = {
    enable = true;
    settings.mainBar = {
      # layer = "top";
      position = "top";
      height = 40;
      modules-left = ["hyprland/workspaces" "hyprland/window" "hyprland/windowcount"];
      modules-center = ["sway/window"];
      modules-right = ["privacy" "hyprland/language" "mpris" "pulseaudio" "bluetooth" "network" "custom/mymodule#with-css-id" "backlight" "clock" "power-profiles-daemon" "gamemode" "battery"];
    };
  };
}
