{ pkgs, ... }:

{
  # List packages installed in system profile. To search by name, run:
  # $ nix-env -qaP | grep wget
  environment.systemPackages = [
    pkgs.vim
    pkgs.direnv
    pkgs.sshs
    pkgs.glow
    pkgs.nushell
    pkgs.carapace
    pkgs.ack
    pkgs.git-lfs
    pkgs.go
    pkgs.lua
    pkgs.zoxide
    pkgs.wget
    pkgs.stern
    pkgs.uv
    (pkgs.bundlerEnv {
      name = "ruby-gems";
      ruby = pkgs.ruby_3_3;
      gemdir = ../ruby;
    })
  ];

  # Disable nix-darwin's Nix management since we're using Determinate Nix
  nix.enable = false;
  nix.settings.experimental-features = "nix-command flakes";

  # Enable alternative shell support in nix-darwin.
  # programs.fish.enable = true;

  # Set Git commit hash for darwin-version.
  system.configurationRevision = null;

  # Used for backwards compatibility, please read the changelog before changing.
  # $ darwin-rebuild changelog
  system.stateVersion = 6;

  # The platform the configuration will be used on.
  nixpkgs.hostPlatform = "aarch64-darwin";
}
