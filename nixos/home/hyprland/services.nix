{pkgs, ...}: {
  services = {
    dunst.enable = true;
    swww.enable = true;
    blueman-applet.enable = true;
    mpd-mpris = {
      enable = true;
      mpd.useLocal = true;
    };
    mpd = {
      enable = true;
      musicDirectory = "true";
      network.startWhenNeeded = true;
    };
    playerctld.enable = true;
  };
}
