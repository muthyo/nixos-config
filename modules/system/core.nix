# Core system configuration
{
  config,
  lib,
  pkgs,
  ...
}: {
  # Core system packages
  environment.systemPackages = with pkgs; [
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

  # Install firefox
  programs.firefox.enable = true;

  # GnuPG configuration
  programs.gnupg.agent = {
    enable = true;
    enableSSHSupport = true;
    settings = {
      default-cache-ttl = 3600;
      max-cache-ttl = 36000;
    };
  };

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

  # Enable XDG desktop portal for proper app integration
  xdg.portal = {
    enable = true;
    extraPortals = [pkgs.xdg-desktop-portal-gtk];
  };
}
