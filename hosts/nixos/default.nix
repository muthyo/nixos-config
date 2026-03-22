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
    ../../modules/desktop/cosmic.nix
    ../../modules/desktop/fonts.nix

    # System services
    ../../modules/services/tailscale.nix
    ../../modules/services/ssh.nix

    # Software categories (easy to enable/disable)
    ../../modules/software/gaming.nix
    ../../modules/software/development.nix
    ../../modules/software/media.nix
    ../../modules/software/browsers.nix
  ];

  networking.hostName = "nixos";
  time.timeZone = "Europe/Oslo";

  # Logitech USB receiver support (host-specific hardware)
  hardware.logitech.wireless.enable = true;

  users.users.muthyo = {
    isNormalUser = true;
    description = "muthyo";
    extraGroups = ["networkmanager" "wheel"];
  };

  system.stateVersion = "24.11";
}
