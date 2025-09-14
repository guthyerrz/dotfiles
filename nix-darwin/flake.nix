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
    # Use fixed values for your specific machine
    actualHostname = "guthy-air";
    actualUsername = "guthy";
    
    configuration = { pkgs, ... }: {
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
      # Nix configuration
      nix.settings.experimental-features = "nix-command flakes";
      programs.zsh.enable = true;  # default shell on catalina
      
      # Configure shell to source our custom zshrc
      environment.loginShell = pkgs.zsh;
      environment.variables.ZDOTDIR = "$HOME";
      system.activationScripts.extraUserActivation.text = ''
        # Link custom zshrc
        if [ ! -L "$HOME/.zshrc" ]; then
          ln -sfn "${../zshrc}/.zshrc" "$HOME/.zshrc"
        fi
      '';
      system.configurationRevision = self.rev or self.dirtyRev or null;
      system.stateVersion = 4;
      nixpkgs.hostPlatform = "aarch64-darwin";
      
      # Updated Touch ID configuration
      security.pam.services.sudo_local.touchIdAuth = true;
      
      # Set primary user for homebrew and system defaults
      system.primaryUser = actualUsername;

      home-manager.backupFileExtension = "backup";

      system.defaults = {
        dock.autohide = true;
        dock.mru-spaces = false;
        finder.AppleShowAllExtensions = true;
        finder.FXPreferredViewStyle = "clmv";
        loginwindow.LoginwindowText = "guthyerrz";
        screencapture.location = "~/Pictures/screenshots";
        screensaver.askForPasswordDelay = 10;
      };

      # Homebrew needs to be installed on its own!
      homebrew.enable = true;
      homebrew.onActivation.cleanup = "zap";
      homebrew.onActivation.autoUpdate = true;
      homebrew.onActivation.upgrade = true;
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
    # Single dynamic configuration that adapts to any host
    darwinConfigurations.${actualHostname} = nix-darwin.lib.darwinSystem {
      system = "aarch64-darwin";
      modules = [
        configuration
        home-manager.darwinModules.home-manager {
          home-manager.useGlobalPkgs = true;
          home-manager.useUserPackages = true;
          # Only configure the specific user, avoid root user configuration
          home-manager.users = {
            ${actualUsername} = import ./home.nix { 
              hostname = actualHostname; 
              username = actualUsername; 
            };
          };
        }
      ];
    };

  };
}
