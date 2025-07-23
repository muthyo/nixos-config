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
    extraPackages = with pkgs; [
      nvidia-vaapi-driver
      libvdpau-va-gl
      # Additional OpenGL libraries for Java applications like RuneLite
      libGL
      libGLU
      mesa
    ];
    extraPackages32 = with pkgs.pkgsi686Linux; [
      # 32-bit OpenGL libraries for RuneLite GPU plugin
      libGL
      libGLU
      mesa
    ];
  };

  # Note: hardware.opengl options have been moved to hardware.graphics
  # The hardware.graphics section above already handles these settings

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
      # Try setting this to false if you have freezing issues
      finegrained = false;
    };

    # NVreg parameters to improve suspend/resume behavior
    nvidiaSettings = true; # Enable the nvidia-settings utility

    # Disable prime offload for desktop systems (helps with gaming stability)
    prime.offload.enableOffloadCmd = lib.mkDefault false;
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

  # Environment variables for NVIDIA + improved gaming compatibility
  environment.sessionVariables = {
    # Electron apps - Browser support
    "NIXOS_OZONE_WL" = "1";

    # Firefox Wayland support
    "MOZ_ENABLE_WAYLAND" = "1";

    # For proper GLX support
    "__GLX_VENDOR_LIBRARY_NAME" = "nvidia";

    # For X11 acceleration when needed
    "MOZ_USE_XINPUT2" = "1";

    # Additional NVIDIA gaming optimizations
    "__GL_GSYNC_ALLOWED" = "1";
    "__GL_VRR_ALLOWED" = "1";
    "__GL_MaxFramesAllowed" = "1";

    # Force composition pipeline off for gaming (better performance)
    "__GL_SYNC_TO_VBLANK" = "0";
  };

  # Temporarily disable Wayland for GNOME to test fullscreen gaming issues
  # You can re-enable this later by changing false to true
  services.displayManager.gdm.wayland = false;
}
