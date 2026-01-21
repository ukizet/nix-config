{
  config,
  lib,
  pkgs,
  ...
}: {
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
      "io.github.flattool.Warehouse"
      "com.usebottles.bottles"
      "com.google.AndroidStudio"
    ];
  };
}
