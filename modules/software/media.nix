{
  config,
  lib,
  pkgs,
  ...
}: {
  environment.systemPackages = with pkgs; [
    vlc
  ];
  # Flatpak is enabled via modules/desktop/cosmic.nix
}
