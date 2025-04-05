# GNOME desktop environment
{
  config,
  lib,
  pkgs,
  ...
}: {
  # Enable the GNOME Desktop Environment
  services.xserver.displayManager.gdm.enable = true;
  services.xserver.desktopManager.gnome.enable = true;

  # GNOME-specific packages
  environment.systemPackages = with pkgs; [
    gnome.gnome-tweaks
    gnomeExtensions.appindicator
  ];

  # Optional: Disable certain GNOME default applications
  environment.gnome.excludePackages = with pkgs; [
    gnome-photos
    gnome-tour
  ];
}
