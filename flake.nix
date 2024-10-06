{
  description = "Nixos config flake";

  inputs = {
    # Nixpkgs 
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    nixpkgs-stable.url = "github:nixos/nixpkgs/nixos-23.05";

    nixos-hardware.url = "github:NixOS/nixos-hardware/master";

    #nixos-boot.url = "path:./modules/plymouth";

    # Stands for "Nix User Repository".
    nur.url = "github:nix-community/NUR"; 

    firefox-addons = {
      url = "gitlab:rycee/nur-expressions?dir=pkgs/firefox-addons";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
 
    nixvim = {
      url = "github:nix-community/nixvim";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    ags.url = "github:Aylur/ags";
  };

  nixConfig = {
    substituters = [
      "https://cache.nixos.org"
    ];
    extra-substituters = [
      "https://hyprland.cachix.org"
      #"https://nix-gaming.cachix.org"
      #"https://anyrun.cachix.org"
      "https://nix-community.cachix.org"
      "https://yazi.cachix.org"
    ];
    extra-trusted-public-keys = [
      "hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc="
      #"nix-gaming.cachix.org-1:nbjlureqMbRAxR1gJ/f3hxemL9svXaZF/Ees8vCUUs4"
      #"anyrun.cachix.org-1:pqBobmOjI7nKlsUMV25u9QHa9btJK65/C8vnO3p346s="
      "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
      "yazi.cachix.org-1:Dcdz63NZKfvUCbDGngQDAZq6kOroIrFoyO064uvLh8k="
    ];
  };


  outputs = { nixpkgs, nixos-hardware, home-manager, nur, ... }@inputs: { #nixos-boot
    nixosConfigurations.nixos = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      specialArgs = {inherit inputs ;};
      modules = [
	nixos-hardware.nixosModules.framework-12th-gen-intel
        home-manager.nixosModules.home-manager
        nur.nixosModules.nur
        #nixos-boot.nixosModules.default
        ./configuration.nix
      ];
    };
  };
}
