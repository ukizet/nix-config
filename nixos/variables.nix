{pkgs, ...}: {
  environment = {
    sessionVariables = {
      NH_FLAKE = "/home/sas/nix-config";
      FLAKE = "/home/sas/nix-config";
    };
  };
}
