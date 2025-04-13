{ config, lib, pkgs, ... }:

{
  services.flatpak = {
    enable = true;
    update.auto = {
      enable = true;
      onCalendar = "monthly"; # Default value
    };
    overrides = {
      global = {
        # Force Wayland by default
        Context.sockets = [
          "wayland"
        ];

        Environment = {
          # Fix un-themed cursor in some Wayland apps
          XCURSOR_PATH = "/run/host/user-share/icons:/run/host/share/icons";

          # Force correct theme for some GTK apps
          GTK_THEME = "Adwaita:dark";
        };
      };
    };
    packages = [
      "com.github.tchx84.Flatseal"
      "com.dec05eba.gpu_screen_recorder"
      "io.github.giantpinkrobots.flatsweep"
      "net.waterfox.waterfox"
      "com.obsproject.Studio"
      "com.ktechpit.torrhunt"
      "org.qbittorrent.qBittorrent"
      "org.gnome.Boxes"
      "com.usebottles.bottles"
      "io.frama.tractor.carburetor"
      "io.github.zen_browser.zen"
      "com.jeffser.Alpaca"
      "com.jeffser.Alpaca.Plugins.Ollama"
      "com.jeffser.Alpaca.Plugins.AMD"
    ];
  };
}
