# Host configuration for 'nixos'
{
  config,
  lib,
  pkgs,
  inputs,
  ...
}: {
  imports = [
    # Hardware configuration
    ./hardware-configuration.nix

    # Core system modules (always enabled)
    ../../modules/core

    # Hardware modules
    ../../modules/hardware/nvidia.nix
    ../../modules/hardware/audio.nix

    # Desktop environment
    ../../modules/desktop/gnome.nix
    ../../modules/desktop/fonts.nix

    # System services
    ../../modules/services/tailscale.nix
    # ../../modules/services/printing.nix
    ../../modules/services/ssh.nix

    # Software categories (easy to enable/disable)
    ../../modules/software/gaming.nix
    ../../modules/software/development.nix
    ../../modules/software/media.nix
    ../../modules/software/browsers.nix
  ];

  # Host-specific configuration
  networking.hostName = "nixos";
  time.timeZone = "Europe/Oslo";

  # User configuration
  users.users.muthyo = {
    isNormalUser = true;
    description = "muthyo";
    extraGroups = ["networkmanager" "wheel"];
  };

  # Host-specific system settings
  system.stateVersion = "24.11";
}
