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
    ".zshrc".source = ~/dotfiles/zshrc/.zshrc;
    ".config/wezterm".source = ~/dotfiles/wezterm;
    ".config/skhd".source = ~/dotfiles/skhd;
    ".config/starship".source = ~/dotfiles/starship;
    ".config/zellij".source = ~/dotfiles/zellij;
    ".config/nvim".source = ~/dotfiles/nvim;
    ".config/nix".source = ~/dotfiles/nix;
    ".config/tmux".source = ~/dotfiles/tmux;
    ".config/ghostty".source = ~/dotfiles/ghostty;
    ".config/aerospace".source = ~/dotfiles/aerospace;
    ".config/sketchybar".source = ~/dotfiles/sketchybar;
    ".config/nushell".source = ~/dotfiles/nushell;
    ".config/hammerspoon".source = ~/dotfiles/hammerspoon;
    ".config/karabiner".source = ~/dotfiles/karabiner;
    ".config/atuin".source = ~/dotfiles/atuin;
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
