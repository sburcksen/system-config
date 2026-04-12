#!/usr/bin/env bash

# Selects a random image from the Wallpaper folder
# and tells hyprpaper to set it as current wallpaper

wallpaper_folder=~/Images/wallpapers
wallpaper=$(find $wallpaper_folder -maxdepth 1 -type f | shuf -n 1)

hyprctl hyprpaper unload all
hyprctl hyprpaper preload "$wallpaper"
hyprctl hyprpaper wallpaper ", $wallpaper"
