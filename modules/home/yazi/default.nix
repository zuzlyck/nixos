_: {
  programs.yazi = {
    enableFishIntegration = true;
    enable = true;
    #package = inputs.yazi.packages.${pkgs.system}.default; # if you use overlays, you can omit this
    settings = {
      manager = {
        sort_dir_first = true;
        show_hidden = true;
      };
    };
  };
}
