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

  # Note: XDG portals (xdg-desktop-portal-cosmic + gtk) are already
  # configured by the COSMIC NixOS module - no manual setup needed.

  # Optional: Enable Flatpak for additional app support
  services.flatpak.enable = lib.mkDefault true;
}
