{pkgs, ...}: {
  home.packages = with pkgs; [
    waybar-mpris
    brightnessctl
    pavucontrol
    networkmanager
    bluez
    bluez-tools
    wlroots
    dunst
    libnotify
    wev
  ];
}
