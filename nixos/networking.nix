{...}: {
  networking = {
    hostName = "nixos"; # Define your hostname.
    networkmanager.enable = true;
    firewall = {
      allowedTCPPorts = [22];
      trustedInterfaces = ["tailscale0"];
    };
  };
}
