{
  description = "NixOS configuration with Hyprland";

  inputs = {
    # Core Nix inputs
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    
    # For bcachefs support - uses a newer kernel
    nixpkgs-bcachefs = {
      url = "github:nixos/nixpkgs/nixos-unstable";
      #inputs.nixpkgs.follows = "nixpkgs";
    };
    
    # Home manager for user configuration
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    
    # Hyprland compositor
    hyprland.url = "github:hyprwm/Hyprland";
    
    # Hardware-specific optimizations
    nixos-hardware.url = "github:NixOS/nixos-hardware";
  };

  outputs = { self, nixpkgs, nixpkgs-bcachefs, home-manager, hyprland, nixos-hardware, ... }@inputs:
    let
      system = "x86_64-linux";
      pkgs = nixpkgs.legacyPackages.${system};
      
      # For bcachefs support, use a custom pkgs with the newest kernel
      bcachefsPkgs = import nixpkgs-bcachefs {
        inherit system;
        config = {
          allowUnfree = true;
        };
        overlays = [];
      };
      
      # Get your actual hostname from your configuration
      hostname = "nixos";
      username = "muthyo";
    in {
      nixosConfigurations.${hostname} = nixpkgs.lib.nixosSystem {
        inherit system;
        specialArgs = { 
          inherit inputs hostname username bcachefsPkgs; 
        };
        modules = [
          # Import your existing hardware configuration
          ./hardware-configuration.nix
          
          # Import your system configuration
          ./configuration.nix
          
          # Import bcachefs module if needed
          ./modules/bcachefs.nix
          
          # Enable Hyprland from flake
          hyprland.nixosModules.default
          { programs.hyprland.enable = true; }
          
          # System-wide configurations and overrides
          ./modules/system.nix
          
          # NVIDIA configurations
          ./modules/nvidia.nix
          
          # Home-Manager as a NixOS module
          home-manager.nixosModules.home-manager {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.extraSpecialArgs = { inherit inputs; };
            home-manager.users.${username} = import ./home/${username}/home.nix;
          }
        ];
      };
    };
}
