{
  pkgs,
  inputs,
  ...
}: {
  home-manager.users.sas = {
    # import the home manager module
    imports = [
      inputs.noctalia.homeModules.default
    ];

    # configure options
    programs.noctalia-shell = {
      enable = true;
      # this may also be a string or a path to a JSON file.
    };
  };
}
