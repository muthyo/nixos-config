# Common configuration for all hosts
{
  config,
  lib,
  pkgs,
  ...
}: {
  imports = [
    # Import all modules needed by all hosts
    ../../modules/system
  ];

  # Flakes
  nix.settings.experimental-features = ["nix-command" "flakes"];

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken.
  system.stateVersion = "24.11"; # Do not change this value!
}
