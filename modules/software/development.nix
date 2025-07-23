# Development tools and utilities
{
  config,
  lib,
  pkgs,
  ...
}: {
  environment.systemPackages = with pkgs; [
    # Core dev tools
    git
    wget
    curl
    gh
    # Container tools
    podman
    podman-compose
    # Nix tools
    nh
    nvd
    nix-output-monitor
    # System utilities
    htop
    usbutils
    cyme
    xdg-utils
    xsel
    xclip
    gnutls
  ];
  # Enable direnv for development environments
  programs.direnv.enable = true;
  # Enable locate service
  services.locate.enable = true;
  # Enable automatic system updates
  system.autoUpgrade = {
    enable = true;
    allowReboot = false;
    channel = "https://nixos.org/channels/nixos-unstable";
  };
  # Enable hardware support
  hardware.logitech.wireless.enable = true;
}