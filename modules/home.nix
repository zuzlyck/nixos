{ inputs, outputs, config, ...}: { 
  home-manager = {
    extraSpecialArgs = {inherit inputs outputs;};
    useGlobalPkgs = false;
    useUserPackages = true;
    users.balint = { 
      imports = map (n: "${./home}/${n}") (builtins.attrNames (builtins.readDir ./home)) ++ [
	inputs.nixvim.homeManagerModules.nixvim
      ];

      nixpkgs.config.allowUnfree = true; 

      home = {
	username = "balint";
	homeDirectory = "/home/balint";
      };

      programs.home-manager.enable = true;
      programs.git.enable = true;

      # Nicely reload system units when changing configs
      systemd.user.startServices = "sd-switch";

      home.stateVersion = "23.11";
    };
  };
}
