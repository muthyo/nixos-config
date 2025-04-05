# Terminal configuration
{
  config,
  lib,
  pkgs,
  ...
}: {
  # Configure Kitty terminal
  programs.kitty = {
    enable = true;
    font = {
      name = "JetBrainsMono Nerd Font";
      size = 12;
    };
    settings = {
      scrollback_lines = 10000;
      enable_audio_bell = false;
      background_opacity = "0.95";
    };

    # Optional: Add themes
    # theme = "Tokyo Night";
  };
}
