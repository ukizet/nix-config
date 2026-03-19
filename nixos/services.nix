{pkgs, ...}: {
  services = {
    # thermald.enable = true;

    # ollama.enable = true;
    tailscale.enable = true;
    openssh = {
      enable = true;
      settings = {
        PasswordAuthentication = false;
        PermitRootLogin = "no";
      };
    };
    logind = {
      # lidSwitchExternalPower = "ignore";
      settings.Login.HandleLidSwitchExternalPower = "ignore";
    };
  };
}
