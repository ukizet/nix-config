{pkgs, ...}: {
  home.packages = with pkgs; [
    playerctl
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
    grimblast
    wlogout
  ];
}
