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

  xdg.portal = {
    enable = true;
    extraPortals = [
      pkgs.xdg-desktop-portal-gtk
    ];
    # Route portal requests to the COSMIC backend first (handles ScreenCast for streaming),
    # falling back to GTK for interfaces COSMIC doesn't implement.
    config.COSMIC.default = [ "cosmic" "gtk" ];
  };

  # Optional: Enable Flatpak for additional app support
  services.flatpak.enable = lib.mkDefault true;
}
