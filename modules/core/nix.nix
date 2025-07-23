# Nix package manager configuration
{
  config,
  lib,
  pkgs,
  ...
}: {
  # Enable flakes
  nix.settings.experimental-features = ["nix-command" "flakes"];

  # Trusted users for devenv
  nix.settings.trusted-users = ["root" "muthyo"];

  # Public keys for caches
  nix.settings.trusted-public-keys = [
    "cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY="
    "devenv.cachix.org-1:w1cLUi8dv3hnoSPGAuibQv+f9TZLr6cv/Hm9XgU50cw="
  ];

  # Garbage collection
  nix.gc = {
    automatic = true;
    dates = "weekly";
    options = "--delete-older-than 7d";
  };

  # Optimize store
  nix.optimise = {
    automatic = true;
    dates = ["weekly"];
  };

  nix.settings.auto-optimise-store = true;

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;
}