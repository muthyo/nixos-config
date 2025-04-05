# Hyprland window manager configuration
{
  config,
  lib,
  pkgs,
  ...
}: {
  # Hyprland is enabled through the flake.nix input

  # Add Hyprland-specific packages
  environment.systemPackages = with pkgs; [
    # Wayland utilities
    xwayland

    # Hyprland tools and utilities
    wofi # Application launcher
    mako # Notification daemon
    swww # Wallpaper
    waybar # Status bar
    wl-clipboard # Clipboard manager
    brightnessctl # Brightness control
    pamixer # Volume control
    grim # Screenshot utility
    slurp # Region selection
  ];

  xdg.portal = {
    wlr.enable = false;
  };
  # Setup XDG portal for Hyprland
  xdg.portal.extraPortals = [
    pkgs.xdg-desktop-portal-hyprland
  ];

  # System-wide Hyprland configuration
  programs.hyprland = {
    # Additional Hyprland settings can be added here
    # These will apply to all users

    # Example of global Hyprland settings:
    # enable = true; # This is already set in flake.nix
    # xwayland.enable = true;
  };
}
