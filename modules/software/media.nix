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
}