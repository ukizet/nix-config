{pkgs, ...}: {
  programs.niri.enable = true;
  services.greetd = {
    enable = true;
    settings = {
      default_session = {
        command = "${pkgs.greetd.tuigreet}/bin/tuigreet --cmd niri-session --time --remember --remember-user-session";
        # user = "sas";
      };
    };
  };
  security = {
    polkit.enable = true;
    pam.services.swaylock = {};
  };
  services.gnome.gnome-keyring.enable = true;
  environment.systemPackages = with pkgs; [
    swaylock
    mako
    swayidle
  ];
}
