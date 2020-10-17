#!/usr/bin/bash

# Terminate already running polybar instances
killall -q polybar

# Wait until the processes have been shut down
while pgrep -u $UID -x polybar >/dev/null; do sleep 1; done

# Launch the damn bar
polybar darkin -c $HOME/.config/polybar/config.ini
