#!/usr/bin/env bash
current_hour=$(date +%H)
if [ -n "$(hyprctl instances)" ]; then
  if [ "$current_hour" -ge 19 ] || [ "$current_hour" -lt 6 ]; then
    hyprshade on /home/balint/.config/hypr/shaders/blue-light-filter.glsl
  else
    hyprshade off
  fi
fi
exit 0
