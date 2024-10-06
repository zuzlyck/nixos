_: {
  programs.foot = {
    enable = true;
    server.enable = true;
    settings = {
      main = {
    	font = "DejaVuSansMono:size=10";
    	dpi-aware = "no";
        workers = "16";
        pad = "3x3";
      };
      colors = {
        alpha = "0.7";
      };
    };
  };
}
