{
  pkgs,
  ...
}:
{
  environment.etc."nextcloud-admin-pass".text = "CG7$q#37T0GjbY";
  services.nextcloud = {
    enable = true;
    package = pkgs.nextcloud31;
    hostName = "localhost";
    config = {
      dbtype = "sqlite";
      adminpassFile = "/etc/nextcloud-admin-pass";
    };
    settings.trusted_domains = [
      "nextcloud.tld"
      "192.168.0.104"
    ];
  };
  networking.nat.enable = true;
  networking.nat.externalInterface = "enp34s0"; # your actual network interface
  networking.nat.forwardPorts = [
    {
      sourcePort = 80;
      destination = "192.168.0.104:80";  # Replace with your host IP
    }
    {
      sourcePort = 443;
      destination = "192.168.0.104:443"; # For HTTPS
    }
  ];

  networking.firewall.allowedTCPPorts = [ 80 443 ]; # Allow traffic through firewall
}
