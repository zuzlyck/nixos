{pkgs, ...}: {
  #home.packages = [ inputs.hyprpaper.packages.${pkgs.system}.hyprpaper ];
  home.packages = [pkgs.hyprpaper];
  xdg.configFile."hypr/hyprpaper.conf".text = ''
    preload = /home/balint/.cache/balint/wallpaper.png
    wallpaper = eDP-1,/home/balint/.cache/balint/wallpaper.png
  '';
}
