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
  };

  # Consolidated NVIDIA configuration
  hardware.nvidia = {
    modesetting.enable = true;
    open = false;
    package = config.boot.kernelPackages.nvidiaPackages.stable;

    # Additional settings for better performance
    forceFullCompositionPipeline = true;

    # PowerMizer settings for better performance and battery life
    powerManagement = {
      enable = true;
    };

    # NVreg parameters to improve suspend/resume behavior
    nvidiaSettings = true; # Enable the nvidia-settings utility
  };

  # Kernel parameters to improve NVIDIA suspend/resume behavior
  boot.kernelParams = [
    "nvidia.NVreg_PreserveVideoMemoryAllocations=1"
    "nvidia-drm.modeset=1"
    "nvidia-drm.fbdev=1"
  ];

  # Disable the nvidia_uvm module during suspend/resume cycle
  services.udev.extraRules = ''
    # Remove NVIDIA USB xHCI Host Controller devices, if present
    ACTION=="add", SUBSYSTEM=="pci", ATTR{vendor}=="0x10de", ATTR{class}=="0x0c0330", ATTR{remove}="1"

    # Remove NVIDIA USB Type-C UCSI devices, if present
    ACTION=="add", SUBSYSTEM=="pci", ATTR{vendor}=="0x10de", ATTR{class}=="0x0c8000", ATTR{remove}="1"
  '';

  # Environment variables for NVIDIA + Wayland - restored for GNOME Wayland
  environment.sessionVariables = {
    # Electron apps - Browser support
    "NIXOS_OZONE_WL" = "1";

    # Firefox Wayland support
    "MOZ_ENABLE_WAYLAND" = "1";

    # For proper GLX support
    "__GLX_VENDOR_LIBRARY_NAME" = "nvidia";

    # For X11 acceleration when needed
    "MOZ_USE_XINPUT2" = "1";
  };

  # Explicitly enable Wayland for GNOME
  services.xserver.displayManager.gdm.wayland = true;
}
