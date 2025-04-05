# Font configuration
{
  config,
  lib,
  pkgs,
  ...
}: {
  # Font configuration
  fonts.packages = with pkgs; [
    noto-fonts
    noto-fonts-emoji
    font-awesome
    nerd-fonts.jetbrains-mono
  ];
}
