{pkgs, ...}: {
  imports = [
    ./waybar
  ];
  programs = {
    kitty.enable = true;
    rofi.enable = true;
  };
}
