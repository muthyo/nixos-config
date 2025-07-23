# Core system modules - always enabled
{
  imports = [
    ./nix.nix
    ./boot.nix
    ./networking.nix
    ./locale.nix
    ./security.nix
  ];
}