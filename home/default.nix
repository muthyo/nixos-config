# Home Manager default configuration
{
  config,
  lib,
  pkgs,
  ...
}: {
  # Import all shared home-manager modules
  imports = [
    ./modules/packages.nix
    ./modules/shell.nix
  ];

  # Let Home Manager manage itself
  programs.home-manager.enable = true;

  # Default options
  home-manager.backupFileExtension = "backup";

  # Set basic session variables for all users
  home.sessionVariables = {
    EDITOR = "hx";
    VISUAL = "hx";
    FLAKE = "~/nixos-config";
  };
}
