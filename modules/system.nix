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

    # Gaming tools
    gamescope # Helps with game rendering and performance
    protontricks # For tweaking Proton games
    winetricks # Useful for Wine configuration

    # Optional tools that can help with certain games
    gamemode # Optimizes system performance while gaming
    mangohud # In-game overlay for monitoring performance
  ];

  # Enable Steam
  programs.steam = {
    enable = true;
    remotePlay.openFirewall = true; # Open ports for Steam Remote Play
    dedicatedServer.openFirewall = true; # Open ports for Steam dedicated server

    # Important: Enable hardware optimizations
    gamescopeSession.enable = true; # Improves gaming performance
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

  # Additional tweaks for better gaming performance
  boot.kernel.sysctl = {
    "vm.max_map_count" = 1048576; # Needed by some games with large memory requirements
  };
}
