{
  home = {
    username = "sas";
    homeDirectory = "/home/sas";
    stateVersion = "23.11";
  };
  programs = {
    git = {
      enable = true;
      userName = "ukizet";
      userEmail = "ukikatuki@gmail.com";
    };
    bash = {
      enable = true;
      shellAliases = {
        lms = "ls -l";
      };
    };
  };
}
