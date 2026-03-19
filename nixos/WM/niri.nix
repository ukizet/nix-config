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
}
