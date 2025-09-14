{ config, pkgs, ... }:

{

  # This value determines the Home Manager release that your
  # configuration is compatible with. This helps avoid breakage
  # when a new Home Manager release introduces backwards
  # incompatible changes.
  #
  # You can update Home Manager without changing this value. See
  # the Home Manager release notes for a list of state version
  # changes in each release.
  home.stateVersion = "25.05";

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

  programs.git = {
    enable = true;
    userName = "Guthyerrz Silva";
    userEmail = "guthyerrz.ufcg@gmail.com";
    extraConfig = {
      branch = {
        autosetuprebase = "always";
      };
      url = {
        "git@git.topfreegames.com:" = {
          insteadof = "https://git.topfreegames.com/";
        };
        "git@github.com:" = {
          insteadof = "git://github.com";
        };
      };
      push = {
        autoSetupRemote = true;
      };
    };
  };
}