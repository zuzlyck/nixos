{pkgs, ...}:
{
  #home.packages = [ inputs.hyprlock.packages.${pkgs.system}.hyprlock ];
  home.packages = [pkgs.hyprlock];
  xdg.configFile."hypr/hyprlock.conf".text = 
  ''
    source = $HOME/.config/hypr/theme.conf

    general {
      disable_loading_bar = false
      hide_cursor = false
      grace = 10
      no_fade_in = true
    }

    background {
      monitor =
      path = /home/balint/.cache/balint/wallpaper.png   # only png supported for now
      color = rgba(25, 20, 20, 1.0)

      # all these options are taken from hyprland, see https://wiki.hyprland.org/Configuring/Variables/#blur for explanations
      blur_size = 4
      blur_passes = 3 # 0 disables blurring
      noise = 0.0117
      contrast = 1.3000 # Vibrant!!!
      brightness = 0.8000
      vibrancy = 0.2100
      vibrancy_darkness = 0.0
    }

    # Current time
    label {
      monitor =
      text = cmd[update:1000] echo "<b><big> $(date +"%H:%M:%S") </big></b>"
      color = rgba(200, 200, 200, 1.0)
      font_size = 64
      font_family = JetBrains Mono Nerd Font 10
      position = 0, 16
      halign = center
      valign = center
    }

    # User label
    label {
      monitor =
      text = Hey <span text_transform="capitalize" size="larger">$USER</span>
      color = rgba(200, 200, 200, 1.0)
      font_size = 20
      font_family = JetBrains Mono Nerd Font 10
      position = 0, 0
      halign = center
      valign = center
    }
  '';
}

