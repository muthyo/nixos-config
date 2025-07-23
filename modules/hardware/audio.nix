# Audio configuration
{
  config,
  lib,
  pkgs,
  ...
}: {
  # Disable PulseAudio
  services.pulseaudio.enable = false;

  # Enable PipeWire
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    # Uncomment if you want JACK support
    # jack.enable = true;
  };
}