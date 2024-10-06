{
  env = [
    "XCURSOR_SIZE,14"
    "XCURSOR_THEME,graphite-dark"
    #"GTK_THEME,FlatColor"
    "GDK_BACKEND=wayland,x11"
    "QT_QPA_PLATFORM=wayland;xcb"
    "CLUTTER_BACKEND=wayland"
    "XDG_CURRENT_DESKTOP=Hyprland"
    "XDG_SESSION_TYPE=wayland"
    "XDG_SESSION_DESKTOP=Hyprland"
    "QT_AUTO_SCREEN_SCALE_FACTOR=1"
    "QT_WAYLAND_DISABLE_WINDOWDECORATION=1"
  ];

  exec-once = [
    #blue light filter
    "shadetoggle"
    #UI, wallpaper
    "ags"
    "hyprpaper"
    #"lxqt-policykit-agent"
    "hypridle"
    #idk 
    #"syncthing"
  ];

  windowrule = [
    "float, file_progress"
    "float, confirm"
    "float, dialog"
    "float, download"
    "float, notification"
    "float, error"
    "float, splash"
    "float, confirmreset"
    "float, title:^(Picture-in-Picture)$"
  ];
}
