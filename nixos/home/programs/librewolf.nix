{
  config,
  pkgs,
  ...
}: {
  programs.librewolf = {
    enable = true;
    settings = {
      "identity.fxaccounts.enabled" = true;
      "privacy.resistFingerprinting" = false;
      "privacy.clearOnShutdown.history" = false;
      "privacy.clearOnShutdown.downloads" = false;
      "network.cookie.lifetimePolicy" = 0;
    };
    profiles.sas = {
      name = "sas";
      settings = {
        "extensions.autoDisableScopes" = 0;
      };
      bookmarks = {
        force = true;
        settings = [
          {
            name = "wikipedia";
            tags = ["wiki"];
            keyword = "wiki";
            url = "https://en.wikipedia.org/wiki/Special:Search?search=%s&amp;go=Go";
          }
          {
            name = "kernel.org";
            url = "https://www.kernel.org";
          }
          {
            name = "Nix sites";
            toolbar = true;
            bookmarks = [
              {
                name = "homepage";
                url = "https://nixos.org/";
              }
              {
                name = "wiki";
                tags = ["wiki" "nix"];
                url = "https://wiki.nixos.org/";
              }
            ];
          }
        ];
      };
      extensions = {
        force = true;
        packages = with pkgs.nur.repos.rycee.firefox-addons; [
          vimium
          bitwarden
        ];
      };
    };
  };
}
