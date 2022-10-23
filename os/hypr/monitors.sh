#!/bin/sh

function monitor_handle {
    if [[ ${1:0:12} == "monitoradded" ]]; then
        hyprctl keyword monitor DP-3,1920x1080,0x0,1 && hyprctl keyword monitor eDP-1,1920x1080,1920x0,1
    fi
}

socat - UNIX-CONNECT:/tmp/hypr/.socket2.sock | while read line; do monitor_handle $line; done

# function has_second_monitor() { set +o errexit
#     hyprland monitors | grep "DP-3"
#     rc=$?
#     set -o errexit
#     echo "$rc"
# }

# if $(has_second_monitor) -eq 0; then
#     hyprctl keyword monitor DP-3,1920x1080,0x0,1 && hyprctl keyword monitor eDP-1,1920x1080,1920x0,1
# fi
