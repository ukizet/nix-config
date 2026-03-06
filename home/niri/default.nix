{pkgs, ...}: {
  home.file.".config/niri/config.kdl".source = ./config.kdl;

  programs = {
    swaylock.enable = true; # Super+Alt+L in the default setting (screen locker)
    fuzzel.enable = true;
  };
  services = {
    mako.enable = true; # notification daemon
    swayidle.enable = true; # idle management daemon
    polkit-gnome.enable = true; # polkit
  };
  home.packages = with pkgs; [
    swaybg # wallpaper
    noctalia-shell
    # fuzzel
    # walker
  ];
}
