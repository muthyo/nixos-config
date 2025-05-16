# System-wide configurations
{
  config,
  lib,
  pkgs,
  hostname,
  username,
  ...
}: {
  # User-requested applications
  environment.systemPackages = with pkgs; [
    # Core utilities
    git
    wget
    curl
    gnupg
    pinentry-curses
    htop
    nh
    nvd
    cyme
    nix-output-monitor
  ];

  # Nix package manager configuration
  nix = {
    # Garbage collection - automatically clean up old generations
    gc = {
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than 7d";
    };

    # Optimize store to save disk space
    optimise = {
      automatic = true;
      dates = ["weekly"];
    };

    # Settings for better performance
    settings = {
      auto-optimise-store = true;
      # Binary caches for faster builds
      substituters = [
        "https://cache.nixos.org/"
      ];
      trusted-public-keys = [
        "cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY="
      ];
    };
  };

  # Font configuration
  fonts.packages = with pkgs; [
    noto-fonts
    noto-fonts-emoji
    font-awesome
    nerd-fonts.jetbrains-mono
  ];

  # Enable XDG desktop portal for proper app integration
  xdg.portal = {
    enable = true;
    extraPortals = [
      pkgs.xdg-desktop-portal-gtk
    ];
  };
}
