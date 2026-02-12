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

  # XDG desktop portal for screen sharing, file dialogs, etc.
  xdg.portal = {
    enable = true;
    extraPortals = [
      pkgs.xdg-desktop-portal-gtk
    ];
  };

  # Optional: Enable Flatpak for additional app support
  services.flatpak.enable = lib.mkDefault true;
}
