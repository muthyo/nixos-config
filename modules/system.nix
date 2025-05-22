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
    tailscale

    # Gaming tools
    gamescope # Helps with game rendering and performance
    protontricks # For tweaking Proton games
    winetricks # Useful for Wine configuration

    # Optional tools that can help with certain games
    gamemode # Optimizes system performance while gaming
    mangohud # In-game overlay for monitoring performance

    # Add Heroic Launcher for Epic Games integration
    heroic

    # Wine dependencies that help with online authentication
    winetricks
    wine
    wine64

    # Additional utilities that help with game launchers
    protonup-qt # For managing Proton versions

    # For browser integration with launchers
    xdg-utils

    # Useful for managing browser integrations
    xsel
    xclip

    # For handling various authentication methods
    gnutls
  ];

  services.tailscale = {
    enable = true;
    openFirewall = true;
    useRoutingFeatures = "client";
  };

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

  # Enable dbus for application communication
  services.dbus.enable = true;

  # Enable XDG desktop portal for proper app integration
  xdg.portal = {
    enable = true;
    extraPortals = [
      pkgs.xdg-desktop-portal-gtk
      pkgs.xdg-desktop-portal-wlr
    ];
    config.common.default = "*";
  };

  # Optional: Allow network discovery for Epic Games services
  networking.firewall = {
    allowedTCPPorts = [
      # Epic Games login and services
      3074
      3478
      3479
    ];
    allowedUDPPorts = [
      3074
      3478
      3479
    ];
  };

  # Additional tweaks for better gaming performance
  boot.kernel.sysctl = {
    "vm.max_map_count" = 1048576; # Needed by some games with large memory requirements
  };
}
