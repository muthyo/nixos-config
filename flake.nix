{
  description = "NixOS configuration with Hyprland";

  inputs = {
    # Core Nix inputs
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    # Home manager for user configuration
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # Hardware-specific optimizations
    nixos-hardware.url = "github:NixOS/nixos-hardware";
  };

  outputs = {
    self,
    nixpkgs,
    home-manager,
    nixos-hardware,
    ...
  } @ inputs: let
    system = "x86_64-linux";
    pkgs = nixpkgs.legacyPackages.${system};

    # Get your actual hostname from your configuration
    hostname = "nixos";
    username = "muthyo";
  in {
    nixosConfigurations.${hostname} = nixpkgs.lib.nixosSystem {
      inherit system;
      specialArgs = {
        inherit inputs hostname username;
      };
      modules = [
        # Import your existing hardware configuration
        ./hardware-configuration.nix

        # Import your system configuration
        ./configuration.nix

        # System-wide configurations and overrides
        ./modules/system.nix

        # NVIDIA configurations
        ./modules/nvidia.nix

        # Home-Manager as a NixOS module
        home-manager.nixosModules.home-manager
        {
          home-manager.useGlobalPkgs = true;
          home-manager.useUserPackages = true;
          home-manager.extraSpecialArgs = {inherit inputs;};
          home-manager.users.${username} = import ./home/${username}/home.nix;
        }
      ];
    };
  };
}
