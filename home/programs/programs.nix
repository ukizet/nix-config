{
  config,
  pkgs,
  ...
}: {
  imports = [
    ./librewolf.nix
    ./zsh.nix
    ./ghostty.nix
  ];

  programs = {
    alacritty = {
      enable = true;
      theme = "catppuccin_macchiato";
    };
    yazi.enable = true;
    rmpc.enable = true;
    git = {
      enable = true;
      userName = "ukizet";
      userEmail = "ukikatuki@gmail.com";
    };
    direnv = {
      enable = true;
      enableZshIntegration = true;
    };
    tmux = {
      enable = true;
      keyMode = "vi";
      disableConfirmationPrompt = true;
    };
    obs-studio = {
      enable = true;
    };
  };
}
