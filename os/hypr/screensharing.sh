#!/bin/bash
# fix screensharing. See
# https://wiki.hyprland.org/Useful-Utilities/Hyprland-desktop-portal/
sleep 1
killall xdg-desktop-portal-hyprland
killall xdg-desktop-portal-wlr
killall xdg-desktop-portal
/usr/libexec/xdg-desktop-portal-hyprland &
sleep 2
/usr/lib/xdg-desktop-portal &
