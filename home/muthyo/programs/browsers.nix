# Browser configuration
{
  config,
  pkgs,
  ...
}: {
  programs.brave = {
    enable = true;
    extensions = [
      "nngceckbapebfimnlniiiahkandclblb" # Bitwarden
      "cjpalhdlnbpafiamejdnhcphjbkeiagm" # uBlock Origin
      "chphlpgkkbolifaimnlloiipkdnihall" # OneTab
    ];
  };
}