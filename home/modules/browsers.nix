# Browser configuration
{
  config,
  lib,
  pkgs,
  ...
}: {
  # Brave browser configuration
  programs.brave = {
    enable = true;

    # Pre-installed extensions
    extensions = [
      "nngceckbapebfimnlniiiahkandclblb" # Bitwarden
      "cjpalhdlnbpafiamejdnhcphjbkeiagm" # uBlock Origin
      "chphlpgkkbolifaimnlloiipkdnihall" # OneTab
    ];
  };

  # Optional: Configure Firefox if needed
  # programs.firefox = {
  #   enable = true;
  #   profiles.default = {
  #     settings = {
  #       "browser.tabs.loadInBackground" = true;
  #     };
  #   };
  # };
}
