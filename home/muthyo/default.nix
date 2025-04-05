# Home Manager configuration for muthyo
{
  config,
  lib,
  pkgs,
  inputs,
  ...
}: {
  imports = [
    # Import base home-manager configuration
    ../default.nix

    # Import user-specific configuration
    ./home.nix

    # Import additional modules
    ../modules/browsers.nix
    ../modules/git.nix
    ../modules/terminal.nix

    # Import editor configurations
    ../editors
  ];

  # Basic home information
  home.username = "muthyo";
  home.homeDirectory = "/home/muthyo";

  # This value determines the Home Manager release that your
  # configuration is compatible with.
  home.stateVersion = "24.11";
}
