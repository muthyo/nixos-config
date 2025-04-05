# Host-specific configuration for nixos
{
  config,
  lib,
  pkgs,
  hostname,
  username,
  ...
}: {
  imports = [
    # Include your hardware configuration
    ./hardware-configuration.nix

    # Import modules specific to this host
    ../../modules/gui/gnome.nix
    ../../modules/gui/hyprland.nix
    ../../modules/system/nvidia.nix
  ];

  # Bootloader configuration
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  # Networking
  networking.hostName = hostname;
  networking.networkmanager.enable = true;

  # Set your time zone
  time.timeZone = "Europe/Oslo";

  # Select internationalisation properties
  i18n.defaultLocale = "en_US.UTF-8";

  # Define a user account
  users.users.${username} = {
    isNormalUser = true;
    description = username;
    extraGroups = ["networkmanager" "wheel"];
  };
}
