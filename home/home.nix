{pkgs, ...}: {
  imports = [
    # ./hyprland
    ./programs
    # ./wineasio.nix
  ];

  home = {
    username = "sas";
    homeDirectory = "/home/sas";
    stateVersion = "25.05";
  };
  xdg.portal = {
    enable = true;
    extraPortals = [pkgs.xdg-desktop-portal-gtk];
  };
}
