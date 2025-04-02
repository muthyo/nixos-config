# System-wide configurations
{
  config,
  lib,
  pkgs,
  bcachefsPkgs,
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
        "https://hyprland.cachix.org"
        "https://cache.nixos.org/"
      ];
      trusted-public-keys = [
        "hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc="
        "cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY="
      ];
    };
  };

  # Audio configuration - keep your existing pipewire setup
  # Display servers - keep your existing X11 setup but add Hyprland

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
      #pkgs.xdg-desktop-portal-hyprland # commented out for now as it is included in flake.nix
    ];
  };
}
