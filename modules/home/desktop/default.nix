{pkgs, ...}: {
  home = {
    file.".themes/FlatColor".source = ./FlatColor;
    file.".themes/dummy".source = ./FlatColor;
    packages = [pkgs.dconf];
  };
  gtk = {
    enable = true;
    font.name = "DejaVuSansMono";
    theme.package = pkgs.gnome-themes-extra;
    theme.name = "FlatColor";
    #gtk3.extraCss = ''
    #  @import url("color");
    #'';
  };

  qt = {
    enable = true;
    platformTheme.name = "gtk";
  };

  home.pointerCursor = {
    name = "graphite-dark";
    package = pkgs.graphite-cursors;
    size = 14;
    gtk.enable = true;
    x11.enable = true;
  };

  # Hides the close button on gnome apps
  dconf.settings = {
    "org/gnome/desktop/wm/preferences".button-layout = "''";
  };
/*
  xdg = {
    enable = true;
    mimeApps.enable = true;
    #mimeApps.addedAssociations = {
    #  "x-scheme-handler/tg" = ["telegramdesktop.desktop"];
    #};
    mimeApps.defaultApplications = let
      browser = ["librewolf.desktop"];
      mediaPlayer = ["mpv.desktop"];
    in {
      "application/x-extension-htm" = browser;
      "application/x-extension-html" = browser;
      "application/x-extension-shtml" = browser;
      "application/x-extension-xht" = browser;
      "application/x-extension-xhtml" = browser;
      "application/xhtml+xml" = browser;
      "text/html" = browser;
      "x-scheme-handler/about" = browser;
      "x-scheme-handler/ftp" = browser;
      "x-scheme-handler/http" = browser;
      "x-scheme-handler/https" = browser;
      "x-scheme-handler/unknown" = browser;
      "x-scheme-handler/chrome" = browser;

      "audio/*" = mediaPlayer;
      "video/*" = mediaPlayer;
      "image/*" = ["eog.desktop"];
      "text/plain" = ["nvim.desktop"];
      "application/json" = browser;
      "application/pdf" = browser; 
      "application/zip" = ["org.cinnamon.FileRoller.desktop"];
      "x-scheme-handler/tg" = ["telegramdesktop.desktop;"];
    };
  };
*/
}

