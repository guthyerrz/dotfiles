{
  description = "My Darwin system flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    nix-darwin.url = "github:LnL7/nix-darwin";
    nix-darwin.inputs.nixpkgs.follows = "nixpkgs";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = inputs@{ self, nix-darwin, nixpkgs, home-manager }:
  let
    # Helper function to create a configuration
    mkDarwinConfig = hostname: username: nix-darwin.lib.darwinSystem {
      system = "aarch64-darwin";
      modules = [
        (configuration hostname username)
        home-manager.darwinModules.home-manager {
          home-manager.useGlobalPkgs = true;
          home-manager.useUserPackages = true;
          home-manager.users.${username} = import ./home.nix { 
            inherit hostname username; 
          };
        }
      ];
    };
    
    configuration = hostname: username: { pkgs, ... }: {
      # List packages installed in system profile. To search by name, run:
      # $ nix-env -qaP | grep wget
      environment.systemPackages =
        [ 
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
      services.nix-daemon.enable = true;
      nix.settings.experimental-features = "nix-command flakes";
      programs.zsh.enable = true;  # default shell on catalina
      system.configurationRevision = self.rev or self.dirtyRev or null;
      system.stateVersion = 4;
      nixpkgs.hostPlatform = "aarch64-darwin";
      security.pam.enableSudoTouchIdAuth = true;

      users.users.${username}.home = "/Users/${username}";
      home-manager.backupFileExtension = "backup";
      nix.configureBuildUsers = true;
      nix.useDaemon = true;

      system.defaults = {
        dock.autohide = true;
        dock.mru-spaces = false;
        finder.AppleShowAllExtensions = true;
        finder.FXPreferredViewStyle = "clmv";
        loginwindow.LoginwindowText = "devops-toolbox";
        screencapture.location = "~/Pictures/screenshots";
        screensaver.askForPasswordDelay = 10;
      };

      # Homebrew needs to be installed on its own!
      homebrew.enable = true;
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
    };
  in
  {
    # Provide multiple common configurations
    darwinConfigurations = {
      # Default fallback configuration
      "default" = mkDarwinConfig "default" (builtins.getEnv "USER");
      
      # Common hostnames - add your machines here
      "guthy-v" = mkDarwinConfig "guthy-v" "guthy";
      "Guthyerrzs-MacBook-Air" = mkDarwinConfig "Guthyerrzs-MacBook-Air" "guthyerrz.silva";
      
      # Generic configurations for common usernames
      "guthy-system" = mkDarwinConfig "guthy-system" "guthy";
      "guthyerrz-system" = mkDarwinConfig "guthyerrz-system" "guthyerrz.silva";
    };

  };
}
