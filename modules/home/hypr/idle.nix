{pkgs, ...}: {
  #home.packages = [ inputs.hypridle.packages.${pkgs.system}.hypridle ];
  home.packages = [pkgs.hypridle];
  xdg.configFile."hypr/hypridle.conf".text = 
  ''
    general { 
      before_sleep_cmd = shadetoggle ; pgrep hyprlock || hyprlock    # command ran before sleep
      #after_sleep_cmd = shadetoggle  # command ran after sleep
      ignore_dbus_inhibit = false             # whether to ignore dbus-sent idle-inhibit requests (used by e.g. firefox or steam)
    }

    listener {
      timeout = 540                           # in seconds
      on-timeout = shadetoggle ; hyprctl activewindow | grep -q "fullscreen: 1" || pgrep hyprlock || hyprlock
      #on-resume =  # command to run when activity is detected after timeout has fired.
    }

    listener {
      timeout = 60
      on-timeout = pgrep hyprlock && systemctl suspend
    }

    listener {
      timeout = 600
      on-timeout = pgrep hyprlock && systemctl suspend
    }
  '';
}
