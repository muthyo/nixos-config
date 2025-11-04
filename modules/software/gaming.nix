# Gaming software and optimizations
{
  config,
  lib,
  pkgs,
  ...
}: {
  # Gaming-related packages
  environment.systemPackages = with pkgs; [
    # Gaming tools
    gamescope
    protontricks
    winetricks
    gamemode
    mangohud
    heroic
    wine
    wine64
    protonup-qt
    steamtinkerlaunch
    vulkan-tools
    mesa-demos
    xorg.xrandr
  ];

  # Enable Steam
  programs.steam = {
    enable = true;
    remotePlay.openFirewall = true;
    dedicatedServer.openFirewall = true;
    gamescopeSession.enable = true;

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

  # Gaming optimizations
  environment.sessionVariables = {
    "GDK_BACKEND" = "x11";
    "__GL_SHADER_DISK_CACHE" = "1";
    "__GL_SHADER_DISK_CACHE_SKIP_CLEANUP" = "1";
    "PROTON_HIDE_NVIDIA_GPU" = "0";
    "PROTON_ENABLE_NVAPI" = "1";
  };

  # Note: Kernel parameters moved to core/boot.nix to avoid conflicts

  # Performance governor
  powerManagement.cpuFreqGovernor = "performance";

  # Gaming firewall ports
  networking.firewall = {
    allowedTCPPorts = [3074 3478 3479];
    allowedUDPPorts = [3074 3478 3479];
  };
}
