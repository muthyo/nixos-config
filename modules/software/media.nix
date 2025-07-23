# Media and entertainment software
{
  config,
  lib,
  pkgs,
  ...
}: {
  environment.systemPackages = with pkgs; [
    # Media player
    vlc
  ];

  # Enable Flatpak for additional media apps
  services.flatpak.enable = true;
}