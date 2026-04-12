#!/usr/bin/env bash

conf_dir=~/.config/waybar
state_file=/tmp/waybar_state_$UID

if [ ! -e $state_file ];
then
    echo "default" > $state_file
fi

if [ $(cat $state_file) = "default" ];
then
    echo "detailed" > $state_file
    pkill waybar
    waybar -c ${conf_dir}/config_detailed.jsonc -s ${conf_dir}/style_detailed.css  
else
    echo "default" > $state_file
    pkill waybar
    waybar 
fi
