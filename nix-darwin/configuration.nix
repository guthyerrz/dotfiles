{ pkgs, ... }:

{
  # Define your user for the system
  users.users.guthy = {
    name = "guthy";
    home = "/Users/guthy";
  };
  
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
    pkgs.trufflehog
    pkgs.bat
    pkgs.pre-commit
    pkgs.openfga-cli
    (pkgs.bundlerEnv {
      name = "ruby-gems";
      ruby = pkgs.ruby_3_3;
      gemdir = ../ruby;
    })
  ];

  # Disable nix-darwin's Nix management since we're using Determinate Nix
  nix.enable = false;
  nix.settings.experimental-features = "nix-command flakes";
  security.pam.services.sudo_local.touchIdAuth = true;

  # Enable alternative shell support in nix-darwin.
  # programs.fish.enable = true;
  programs.zsh.enable = true;

  # Set Git commit hash for darwin-version.
  system.configurationRevision = null;
  
  system.primaryUser = "guthy";

  # Used for backwards compatibility, please read the changelog before changing.
  # $ darwin-rebuild changelog
  system.stateVersion = 6;

  homebrew.enable = true;
  homebrew.onActivation.cleanup = "zap";
  homebrew.onActivation.autoUpdate = true;
  homebrew.onActivation.upgrade = true;
  homebrew.caskArgs.appdir = "/Applications";
  homebrew.casks = [
    "google-chrome"
    "ngrok"
    "whatsapp"
    "surfshark"
    "spotify"
    "slack"
    "raycast"
    "proton-pass"
    "postman"
    "localsend"
    "ghostty"
    "fork"
    "docker-desktop"
    "cursor"
    "charles"
    "android-studio"
  ];
  homebrew.brews = [
    "imagemagick"
    "kubernetes-cli"
    "kube-ps1"
    "kubectx"
    "xcbeautify"
  ];

  # The platform the configuration will be used on.
  nixpkgs.hostPlatform = "aarch64-darwin";

  system.defaults = {
    dock.autohide = true;
    finder.AppleShowAllExtensions = true;
    finder.FXPreferredViewStyle = "Nlsv";
    finder._FXShowPosixPathInTitle = true;
    finder.CreateDesktop = false;
    finder.FXEnableExtensionChangeWarning = false;
    finder.NewWindowTarget = "Other";
    finder.NewWindowTargetPath = "~/";
    finder.QuitMenuItem = true;
    finder.ShowExternalHardDrivesOnDesktop = false;
    finder.ShowRemovableMediaOnDesktop = false;
    loginwindow.LoginwindowText = "guthyerrz";
    screencapture.location = "~/Pictures/screenshots";
    screensaver.askForPasswordDelay = 10;
    NSGlobalDomain.InitialKeyRepeat = 10;
    NSGlobalDomain.KeyRepeat = 1;
  };
}
