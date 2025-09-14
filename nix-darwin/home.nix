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

  # Home Manager manages all dotfiles declaratively
  # Note: .zshrc is managed by nix-darwin, not home-manager
  home.file = {
    ".config/wezterm".source = ../wezterm;
    ".config/skhd".source = ../skhd;
    ".config/starship".source = ../starship;
    ".config/zellij".source = ../zellij;
    ".config/nvim".source = ../nvim;
    ".config/nix".source = ../nix;
    ".config/tmux".source = ../tmux;
    ".config/ghostty".source = ../ghostty;
    ".config/aerospace".source = ../aerospace;
    ".config/sketchybar".source = ../sketchybar;
    ".config/nushell".source = ../nushell;
    ".config/hammerspoon".source = ../hammerspoon;
    ".config/karabiner".source = ../karabiner;
    ".config/atuin".source = ../atuin;
  };

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