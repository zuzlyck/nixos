#!/usr/bin/env bash

wallpapers="/home/$USER/wallpapers"
cache="/home/$USER/.cache/$USER"

if [ -z "$(ls -A $wallpapers)" ]; then
  image="$NIXOS_CONFIG_DIR/import/home-manager/hyprpaper/fallback.png"
else
  image="$(ls $wallpapers/* |sort -R |tail -1)"
fi

if [ -s $cache/wallpaper.png ]; then
  rm $cache/wallpaper.png
fi

cp $image $cache/wallpaper.png

hyprctl hyprpaper preload $image
hyprctl hyprpaper wallpaper "eDP-1,$image"
hyprctl hyprpaper unload all
