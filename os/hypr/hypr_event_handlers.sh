#!/bin/bash

# for a complete list of events see https://wiki.hyprland.org/IPC/#events-list

function event::monitoradded() {
  local -r monitor_name="${1:14}"
  notify-send "Monitor connected" $monitor_name

  [[ $monitor_name == "DP-3" ]] && \
    hyprctl keyword monitor DP-3,1920x1080,0x0,1 && hyprctl keyword monitor eDP-1,1920x1080,1920x0,1
}

function event::monitorremoved() {
  local -r monitor_name="${1:16}"
  notify-send "Monitor disconnected" $monitor_name
}
