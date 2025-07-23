# Internationalization and locale settings
{
  config,
  lib,
  pkgs,
  ...
}: {
  # Locale settings
  i18n.defaultLocale = "en_US.UTF-8";

  # Console keymap
  console.keyMap = "no";
}