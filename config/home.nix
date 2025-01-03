{ config, pkgs, ... }:

{
  home.username = "stianfroystein";
  home.homeDirectory = "/Users/stianfroystein";
  home.stateVersion = "24.11"; # Please read the comment before changing.
  home.packages = [
    pkgs.hello
  ];

  home.file = {
    ".config/wezterm/wezterm.lua".source = ./dotfiles/wezterm.lua;
    ".config/tmux/tmux.conf".source = ./dotfiles/tmux.conf;
    ".hammerspoon/init.lua".source = ./dotfiles/hammerspoon.lua;
    ".config/karabiner/karabiner.json".source = ./dotfiles/karabiner.json;
    ".config/ghostty/config".source = ./dotfiles/ghostty;
    ".config/yabai/yabairc".source = ./dotfiles/yabairc;
    ".config/btop/btop.conf".source = ./dotfiles/btop.conf;
    ".config/btop/themes/catppuccin_mocha.theme".source = ./dotfiles/btop.theme;
  };

  home.sessionVariables = {
    HOMEBREW_NO_ENV_HINTS = 1;
    EDITOR = "nvim";
  };

  programs.home-manager.enable = true;

  programs.fish = {
    enable = true;
    shellAliases = {
      lg = "lazygit";
      vim = "nvim";
    };
    shellInit = ''
      set fish_cursor_default block
      set fish_cursor_insert line
      set fish_cursor_replace_one underscore
      set fish_cursor_visual block

      fish_vi_key_bindings

      if set -q TMUX
        fish_vi_cursor xterm
      end
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
}
