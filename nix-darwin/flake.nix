{
  description = "Example nix-darwin system flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    nix-darwin.url = "github:nix-darwin/nix-darwin/master";
    nix-darwin.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = inputs@{ self, nix-darwin, nixpkgs }:
  let
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

      # Disable nix-darwin's Nix management since we're using Determinate Nix
      nix.enable = false;

      # Enable alternative shell support in nix-darwin.
      # programs.fish.enable = true;

      # Set Git commit hash for darwin-version.
      system.configurationRevision = self.rev or self.dirtyRev or null;

      # Used for backwards compatibility, please read the changelog before changing.
      # $ darwin-rebuild changelog
      system.stateVersion = 6;

      # The platform the configuration will be used on.
      nixpkgs.hostPlatform = "aarch64-darwin";
    };
  in
  {
    # Build darwin flake using:
    # $ darwin-rebuild build --flake .#guthy-air
    darwinConfigurations."guthy-air" = nix-darwin.lib.darwinSystem {
      modules = [ configuration ];
    };
  };
}
