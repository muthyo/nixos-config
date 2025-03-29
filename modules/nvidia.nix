# NVIDIA-specific configurations
{
  config,
  lib,
  pkgs,
  ...
}: {
  # NVIDIA drivers configuration
  services.xserver.videoDrivers = ["nvidia"];

  hardware.graphics = {
    enable = true;
    enable32Bit = true; # For 32-bit applications
    # Removed driSupport as it's no longer needed
  };

  # Consolidated NVIDIA configuration
  hardware.nvidia = {
    modesetting.enable = true;
    open = true; # Based on your current config
    package = config.boot.kernelPackages.nvidiaPackages.stable;

    # Additional settings for better Wayland support
    forceFullCompositionPipeline = true;

    # PowerMizer settings for better performance and battery life
    powerManagement = {
      enable = true;
      # Removed finegrained = true since you don't have a hybrid graphics setup
    };
  };

  # Environment variables for NVIDIA + Wayland
  environment.sessionVariables = {
    # Electron apps - Browser support
    "NIXOS_OZONE_WL" = "1";

    # Hardware cursor fix for NVIDIA on Wayland
    "WLR_NO_HARDWARE_CURSORS" = "1";
    "GBM_BACKEND" = "nvidia-drm";

    # Firefox Wayland support
    "MOZ_ENABLE_WAYLAND" = "1";

    # For proper GLX support
    "__GLX_VENDOR_LIBRARY_NAME" = "nvidia";
  };
}
