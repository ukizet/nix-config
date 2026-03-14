{
  config,
  pkgs,
  ...
}: {
  imports = [
    ./niri
  ];

  programs = {
    # alacritty = {
    #   enable = true;
    #   theme = "catppuccin_macchiato";
    #   settings = {
    #     window = {
    #     decorations = "None";
    #     };
    #     font.size = 16;
    #   };
    # };
    # yazi.enable = true;
    # rmpc.enable = true;
    # git = {
    #   enable = true;
    #   userName = "ukizet";
    #   userEmail = "ukikatuki@gmail.com";
    # };
    # tmux = {
    #   enable = true;
    #   keyMode = "vi";
    #   disableConfirmationPrompt = true;
    # };
    # obs-studio = {
    #   enable = true;
    # };
  };
}
