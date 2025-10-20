{
  config,
  pkgs,
  ...
}: {
  programs.ghostty = {
    enable = true;
    enableZshIntegration = true;
    installVimSyntax = true;
    settings = {
      theme = "catppuccin-mocha";
      font-size = 18;
    };
  };
}
