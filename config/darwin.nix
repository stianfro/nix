{ config, pkgs, ... }:

{
  homebrew = {
    enable = true;
    taps = [
      "koekeishiya/formulae"
      "FelixKratz/formulae"
    ];
    brews = [
      "mas"
      "kind"
      "yabai"
      "borders"
    ];
    casks = [
      "firefox"
      "linearmouse"
      "wezterm"
      "steam"
      "1password"
      "hammerspoon"
      "docker"
      "karabiner-elements"
      "utm"
      "ghostty"
      "visual-studio-code"
      "chatgpt"
      "yacreader"
    ];
    masApps = {
      "Pure Paste" = 1611378436;
    };
    onActivation.cleanup = "zap";
    onActivation.autoUpdate = true;
    onActivation.upgrade = true;
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

  system.defaults = {
    dock.autohide = true;
    dock.persistent-apps = [
      "/Applications/Firefox.app"
      "/Applications/Ghostty.app"
      "/Applications/Visual Studio Code.app"
      "/Applications/ChatGPT.app"
      "/System/Applications/System Settings.app"
    ];
    dock.show-recents = false;
    finder.FXPreferredViewStyle = "clmv";
    NSGlobalDomain.AppleICUForce24HourTime = true;
    NSGlobalDomain.AppleInterfaceStyle = "Dark";
    NSGlobalDomain.AppleInterfaceStyleSwitchesAutomatically = false;
  };
}
