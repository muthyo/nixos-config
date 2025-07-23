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

    # COSMIC Desktop Environment (optional)
    nixos-cosmic = {
      url = "github:lilyinstarlight/nixos-cosmic";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = {
    self,
    nixpkgs,
    home-manager,
    nixos-hardware,
    nixos-cosmic,
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
        # Use the modular host configuration
        ./hosts/${hostname}/default.nix

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
