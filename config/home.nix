{ config, pkgs, ... }:

{
  # Home Manager needs a bit of information about you and the paths it should
  # manage.
  home.username = "stianfroystein";
  home.homeDirectory = "/Users/stianfroystein";

  # This value determines the Home Manager release that your configuration is
  # compatible with. This helps avoid breakage when a new Home Manager release
  # introduces backwards incompatible changes.
  #
  # You should not change this value, even if you update Home Manager. If you do
  # want to update the value, then make sure to first check the Home Manager
  # release notes.
  home.stateVersion = "24.11"; # Please read the comment before changing.

  # The home.packages option allows you to install Nix packages into your
  # environment.
  home.packages = [
    # # Adds the 'hello' command to your environment. It prints a friendly
    # # "Hello, world!" when run.
    pkgs.hello

    # # It is sometimes useful to fine-tune packages, for example, by applying
    # # overrides. You can do that directly here, just don't forget the
    # # parentheses. Maybe you want to install Nerd Fonts with a limited number of
    # # fonts?
    # (pkgs.nerdfonts.override { fonts = [ "FantasqueSansMono" ]; })

    # # You can also create simple shell scripts directly inside your
    # # configuration. For example, this adds a command 'my-hello' to your
    # # environment:
    # (pkgs.writeShellScriptBin "my-hello" ''
    #   echo "Hello, ${config.home.username}!"
    # '')
  ];

  # home.file.".wezterm".source = ./

  # Home Manager is pretty good at managing dotfiles. The primary way to manage
  # plain files is through 'home.file'.
  home.file = {
    # # Building this configuration will create a copy of 'dotfiles/screenrc' in
    # # the Nix store. Activating the configuration will then make '~/.screenrc' a
    # # symlink to the Nix store copy.
    # ".screenrc".source = dotfiles/screenrc;
    ".config/wezterm/wezterm.lua".source = ./dotfiles/wezterm.lua;
    ".config/tmux/tmux.conf".source = ./dotfiles/tmux.conf;
    ".hammerspoon/init.lua".source = ./dotfiles/hammerspoon.lua;
    ".config/karabiner/karabiner.json".source = ./dotfiles/karabiner.json;

    # # You can also set the file content immediately.
    # ".gradle/gradle.properties".text = ''
    #   org.gradle.console=verbose
    #   org.gradle.daemon.idletimeout=3600000
    # '';

    # ".ssh/config".text = ''
    #   Host *
    #     UseKeychain yes
    # '';
  };

  # Home Manager can also manage your environment variables through
  # 'home.sessionVariables'. These will be explicitly sourced when using a
  # shell provided by Home Manager. If you don't want to manage your shell
  # through Home Manager then you have to manually source 'hm-session-vars.sh'
  # located at either
  #
  #  ~/.nix-profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  ~/.local/state/nix/profiles/profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  /etc/profiles/per-user/stianfroystein/etc/profile.d/hm-session-vars.sh
  #
  home.sessionVariables = {
    HOMEBREW_NO_ENV_HINTS = 1;
    EDITOR = "nvim";
  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

  programs.fish = {
    enable = true;
    shellAliases = {
      lg = "lazygit";
      vim = "nvim";
    };
    shellInit = ''
      fish_vi_key_bindings
    '';
    functions = {
      gclone = ''
        set dir (echo $argv | sed 's/^http\(s*\):\/\///g' | sed 's/^git@//g' | sed 's/\.git$//g' | sed 's/:/\//g')
        git clone $argv "$HOME/src/$dir"
        cd "$HOME/src/$dir"
      '';
    };
  };

  programs.oh-my-posh = {
    enable = true;
    enableFishIntegration = true;
    enableZshIntegration = true;
    useTheme = "catppuccin_mocha";
  };

  programs.k9s = {
    enable = true;
  };

  programs.ssh = {
    enable = true;
    addKeysToAgent = "yes";
    extraConfig = "UseKeychain yes";
  };

  programs.zoxide = {
    enable = true;
    enableFishIntegration = true;
  };

  # programs.tmux = {
  #   enable = true;
  #   prefix = "C-Space";
  #   keyMode = "vi";
  # };
}
