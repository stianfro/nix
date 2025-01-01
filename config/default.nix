{ config, pkgs, ... }:

{
  environment.systemPackages = [
    pkgs.neovim
    pkgs.tmux
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
    pkgs.nodejs_23
    pkgs.python3Minimal
    pkgs.btop
    pkgs.tree
    pkgs.babelfish
    pkgs.ranger
    pkgs.macchina
    pkgs.btop
  ];

  fonts.packages = [
    pkgs.nerd-fonts.jetbrains-mono
  ];
}
