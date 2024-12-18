{
  description = "Stians darwin flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    nix-darwin.url = "github:LnL7/nix-darwin";
    nix-darwin.inputs.nixpkgs.follows = "nixpkgs";
    nix-homebrew.url = "github:zhaofengli-wip/nix-homebrew";
  };

  outputs = inputs@{ self, nix-darwin, nixpkgs, nix-homebrew }:
    let
      configuration = { pkgs, config, ... }: {
        # List packages installed in system profile. To search by name, run:
        # $ nix-env -qaP | grep wget
        environment.systemPackages =
          [
            pkgs.neovim
            pkgs.tmux
            pkgs.wezterm
            pkgs.mkalias
            pkgs.oh-my-posh
            pkgs.fish
            pkgs.go
            pkgs.rustup
            pkgs.wget
            pkgs.curl
            pkgs.zoxide
            pkgs.tree-sitter
            pkgs.lazygit
            pkgs.ripgrep
            pkgs.nodejs-slim
            pkgs.python3Minimal
            pkgs.btop
          ];

        fonts.packages = [
          # (pkgs.nerdfonts.override { fonts = [ "JetBrainsMono" ]; })
          pkgs.nerd-fonts.jetbrains-mono
        ];

        homebrew = {
          enable = true;
          brews = [
            "mas"
          ];
          casks = [
            "firefox"
            "karabiner-elements"
            "linearmouse"
          ];
          masApps = {
            "Pure Paste" = 1611378436;
            "Dato" = 1470584107;
          };
          onActivation.cleanup = "zap";
        };

        system.activationScripts.applications.text =
          let
            env = pkgs.buildEnv {
              name = "system-applications";
              paths = config.environment.systemPackages;
              pathsToLink = "/Applications";
            };
          in
          pkgs.lib.mkForce ''
            # Set up applications.
            echo "setting up /Applications..." >&2
            rm -rf /Applications/Nix\ Apps
            mkdir -p /Applications/Nix\ Apps
            find ${env}/Applications -maxdepth 1 -type l -exec readlink '{}' + |
            while read -r src; do
              app_name=$(basename "$src")
              echo "copying $src" >&2
              ${pkgs.mkalias}/bin/mkalias "$src" "/Applications/Nix Apps/$app_name"
            done
          '';

        # Necessary for using flakes on this system.
        nix.settings.experimental-features = "nix-command flakes";

        # Enable alternative shell support in nix-darwin.
        # programs.fish.enable = true;

        # Set Git commit hash for darwin-version.
        system.configurationRevision = self.rev or self.dirtyRev or null;

        # Used for backwards compatibility, please read the changelog before changing.
        # $ darwin-rebuild changelog
        system.stateVersion = 5;

        # The platform the configuration will be used on.
        nixpkgs.hostPlatform = "aarch64-darwin";
      };
    in
    {
      # Build darwin flake using:
      # $ darwin-rebuild build --flake .#simple
      darwinConfigurations.m1 = nix-darwin.lib.darwinSystem {
        modules = [
          configuration
          nix-homebrew.darwinModules.nix-homebrew
          {
            nix-homebrew = {
              enable = true;
              enableRosetta = true;
              user = "stianfroystein";
              autoMigrate = true;
            };
          }
        ];
      };
    };
}
