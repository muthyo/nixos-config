# GNOME Desktop Environment
{
  config,
  lib,
  pkgs,
  ...
}: {
  # Enable X11
  services.xserver.enable = true;

  # Enable GNOME
  services.displayManager.gdm.enable = true;
  services.desktopManager.gnome.enable = true;

  # Temporarily disable Wayland for better gaming compatibility
  services.displayManager.gdm.wayland = false;

  # Configure keymap
  services.xserver.xkb = {
    layout = "no,us";
    variant = "";
  };

  # Enable XDG desktop portal
  xdg.portal = {
    enable = true;
    extraPortals = [
      pkgs.xdg-desktop-portal-gtk
      pkgs.xdg-desktop-portal-wlr
    ];
    config.common.default = "*";
  };

  # Enable dbus
  services.dbus.enable = true;
}