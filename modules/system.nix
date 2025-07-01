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

    # Additional gaming-related packages
    vulkan-tools # For Vulkan debugging
    glxinfo # For OpenGL debugging
    xorg.xrandr # For display management
    steamtinkerlaunch # Advanced Steam launch options manager

    # Media player
    vlc

    # Container management
    podman
    podman-compose

    # Development tools
    gh # GitHub CLI
  ];

  services.tailscale = {
    enable = true;
    openFirewall = true;
    useRoutingFeatures = "client";
  };

  # Enable Steam with improved compatibility
  programs.steam = {
    enable = true;
    remotePlay.openFirewall = true; # Open ports for Steam Remote Play
    dedicatedServer.openFirewall = true; # Open ports for Steam dedicated server

    # Important: Enable hardware optimizations
    gamescopeSession.enable = true; # Improves gaming performance

    # Additional Steam package overrides for better compatibility
    package = pkgs.steam.override {
      extraPkgs = pkgs:
        with pkgs; [
          xorg.libXcursor
          xorg.libXi
          xorg.libXinerama
          xorg.libXScrnSaver
          libpng
          libpulseaudio
          libvorbis
          stdenv.cc.cc.lib
          libkrb5
          keyutils
        ];
    };
  };

  # Gaming-specific environment variables for better Proton compatibility
  environment.sessionVariables = {
    # Force X11 for Steam/Proton (may help with fullscreen issues)
    "GDK_BACKEND" = "x11";

    # NVIDIA-specific optimizations
    "__GL_SHADER_DISK_CACHE" = "1";
    "__GL_SHADER_DISK_CACHE_SKIP_CLEANUP" = "1";

    # Proton optimizations
    "PROTON_HIDE_NVIDIA_GPU" = "0";
    "PROTON_ENABLE_NVAPI" = "1";
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

  # Kernel parameters for gaming performance
  boot.kernelParams = [
    # NVIDIA parameters
    "nvidia.NVreg_PreserveVideoMemoryAllocations=1"
    "nvidia-drm.modeset=1"
    "nvidia-drm.fbdev=1"

    # Gaming-specific parameters
    "split_lock_detect=off" # Helps with some game compatibility
  ];

  # Performance governor for gaming
  powerManagement.cpuFreqGovernor = "performance";

  # Increase file descriptor limits for gaming
  security.pam.loginLimits = [
    {
      domain = "*";
      type = "soft";
      item = "nofile";
      value = "1048576";
    }
    {
      domain = "*";
      type = "hard";
      item = "nofile";
      value = "1048576";
    }
  ];
}
