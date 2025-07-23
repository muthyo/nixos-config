# Home Manager configuration for muthyo
{
  config,
  pkgs,
  inputs,
  lib,
  ...
}: {
  # Let Home Manager manage itself
  programs.home-manager.enable = true;

  # User info
  home.username = "muthyo";
  home.homeDirectory = "/home/muthyo";

  # Import program configurations
  imports = [
    ./programs/terminal.nix
    ./programs/git.nix
    ./programs/browsers.nix
    ./programs/applications.nix
    ./editors.nix
  ];

  # Environment variables
  home.sessionVariables = {
    EDITOR = "hx";
    VISUAL = "hx";
    NH_FLAKE = "/home/muthyo/nixos-config";
  };

  # Home Manager release compatibility
  home.stateVersion = "24.11";
}