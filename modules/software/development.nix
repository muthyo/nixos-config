{
  config,
  lib,
  pkgs,
  ...
}: {
  environment.systemPackages = with pkgs; [
    git
    wget
    curl
    gh
    podman
    podman-compose
    nh
    nvd
    nix-output-monitor
    htop
    usbutils
    cyme
    xdg-utils
    xsel
    xclip
    gnutls
    file
    unzip
  ];

  programs.direnv.enable = true;
  services.locate.enable = true;
}
