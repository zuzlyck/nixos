{ pkgs, ... }: {
  programs.mpv = {
    enable = true;
    scripts = with pkgs.mpvScripts; [
      webtorrent-mpv-hook
      uosc
      autocrop
      visualizer
      quality-menu
      mpv-cheatsheet
    ];
    scriptOpts = {
      webtorrent = {
        path = "/tmp";
      };
    };
  };
}
