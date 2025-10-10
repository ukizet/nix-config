{pkgs, ...}: {
  environment = {
    variables = {
      # enable opencl on polaris
      ROC_ENABLE_PRE_VEGA = "1";
      AMD_VULKAN_ICD = "RADV";
    };
    sessionVariables = {
      NIXOS_OZONE_WL = "1";
      NH_FLAKE = "/home/sas/nix-config";
      FLAKE = "/home/sas/nix-config";
      # WINEPREFIX = "not defined. Install ableton somewhere first";
    };
  };
}
