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
}
