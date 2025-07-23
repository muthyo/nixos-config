# Basic networking configuration
{
  config,
  lib,
  pkgs,
  ...
}: {
  # Enable networking
  networking.networkmanager.enable = true;

  # Basic firewall
  networking.firewall.enable = true;
}