{
  #I/O, control, etc
  binde = [
    ", XF86AudioRaiseVolume, exec, wpctl set-volume -l 1 @DEFAULT_AUDIO_SINK@ 5%+"
    ", XF86AudioLowerVolume, exec, wpctl set-volume -l 1 @DEFAULT_AUDIO_SINK@ 5%-"
    "SHIFT, XF86AudioRaiseVolume, exec, wpctl set-volume -l 1.5 @DEFAULT_AUDIO_SINK@ 5%+"
    "SHIFT, XF86AudioLowerVolume, exec, wpctl set-volume -l 1.5 @DEFAULT_AUDIO_SINK@ 5%-"
    ", XF86AudioMute, exec, wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"
    ", XF86AudioPrev, exec, playerctl previous"
    ", XF86AudioPlay, exec, playerctl play-pause"
    ", XF86AudioNext, exec, playerctl next"
    ", XF86MonBrightnessUp, exec, brightnessctl set 5%+ -n 100 -e"
    ", XF86MonBrightnessDown, exec, brightnessctl set 5%- -n 100 -e"
  ];

  bind = [
    #Fn-row
    #Screenshot
    ", Print, exec, hyprshot -m region -o ~/Pictures/"
    #TODO record video
    #Misc
    "SUPER, A, exec, rofi -show drun"
    "SUPER, W, exec, librewolf"
    "SUPER, T, exec, foot"
    "SUPER, C, exec, hyprpicker -a"
    "SUPER, L, exec, hyprlock"
    "SUPER, E, exec, nemo"
    "SUPER, B, exec, switchbg"
    "SUPER, P, exec, keepassxc"
    "SUPER SHIFT, p, exec, poweroff"
    #Windows
    "SUPER, Q, killactive,"
    "SUPER, K, exec, hyprctl kill"
    "SUPER SHIFT, Q, exit,"
    "SUPER, F, fullscreen,"
    "SUPER, Space, togglefloating,"
    "SUPER, S, togglesplit,"
    #Focus
    #"SUPER, h, movefocus, l"
    #"SUPER, l, movefocus, r"
    #"SUPER, k, movefocus, u"
    #"SUPER, j, movefocus, d"
    #Move
    "SUPER, left, movewindow, l"
    "SUPER, right, movewindow, r"
    "SUPER, up, movewindow, u"
    "SUPER, down, movewindow, d"
    #Resize
    "SUPER SHIFT, left, resizeactive, -10 0"
    "SUPER SHIFT, right, resizeactive, 10 0"
    "SUPER SHIFT, up, resizeactive, 0 -10"
    "SUPER SHIFT, down, resizeactive, 0 10"
    #Tabbed
    "SUPER, g, togglegroup"
    "SUPER, tab, changegroupactive"
    #Switch
    "SUPER, 1, workspace, 1"
    "SUPER, 2, workspace, 2"
    "SUPER, 3, workspace, 3"
    "SUPER, 4, workspace, 4"
    "SUPER, 5, workspace, 5"
    "SUPER, 6, workspace, 6"
    "SUPER, 7, workspace, 7"
    "SUPER, 8, workspace, 8"
    "SUPER, 9, workspace, 9"
    "SUPER, 0, workspace, 10"
    "SUPER ALT, up, workspace, e+1"
    "SUPER ALT, down, workspace, e-1"
    #Move
    "SUPER SHIFT, 1, movetoworkspace, 1"
    "SUPER SHIFT, 2, movetoworkspace, 2"
    "SUPER SHIFT, 3, movetoworkspace, 3"
    "SUPER SHIFT, 4, movetoworkspace, 4"
    "SUPER SHIFT, 5, movetoworkspace, 5"
    "SUPER SHIFT, 6, movetoworkspace, 6"
    "SUPER SHIFT, 7, movetoworkspace, 7"
    "SUPER SHIFT, 8, movetoworkspace, 8"
    "SUPER SHIFT, 9, movetoworkspace, 9"
    "SUPER SHIFT, 0, movetoworkspace, 10"
  ];

  bindm = [
    #Mouse binding
    "SUPER, mouse:272, movewindow"
    "SUPER, mouse:273, resizewindow"
  ];
}
