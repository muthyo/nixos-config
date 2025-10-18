# COSMIC Desktop Environment
{
  config,
  lib,
  pkgs,
  ...
}: {
  # Enable COSMIC desktop using native NixOS support (no flake required)
  services.desktopManager.cosmic.enable = true;
  services.displayManager.cosmic-greeter.enable = true;

  # Enable XWayland support in COSMIC
  services.desktopManager.cosmic.xwayland.enable = true;

  # Optional: Enable Flatpak for additional app support
  services.flatpak.enable = lib.mkDefault true;
}
