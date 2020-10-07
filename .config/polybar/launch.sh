#!/usr/bin/env bash

# Terminate already running bar instances
killall -q polybar

# Launch polybar
polybar koolbar -c ~/.config/polybar/config.ini
