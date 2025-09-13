# home.nix
# home-manager switch 

{ config, pkgs, ... }:

{
  home.username = "guthy";
  home.homeDirectory = "/Users/guthy";
  home.stateVersion = "23.05"; # Please read the comment before changing.

# Makes sense for user specific applications that shouldn't be available system-wide
  home.packages = [
  ];

  # Home Manager manages all dotfiles declaratively
  home.file = {
    ".zshrc".source = ../zshrc/.zshrc;
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

  home.sessionVariables = {
  };

  home.sessionPath = [
    "/run/current-system/sw/bin"
      "$HOME/.nix-profile/bin"
  ];
  programs.home-manager.enable = true;
  programs.zsh = {
    enable = true;
    initExtra = ''
      # Add any additional configurations here
      export PATH=/run/current-system/sw/bin:$HOME/.nix-profile/bin:$PATH
      if [ -e '/nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh' ]; then
        . '/nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh'
      fi
    '';
  };
}
