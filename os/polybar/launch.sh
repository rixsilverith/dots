#!/usr/bin/bash

# Terminate already running polybar instances
killall -q polybar

# Wait until the processes have been shut down
while pgrep -u $UID -x polybar >/dev/null; do sleep 1; done

# Launch the bar
echo "---" | tee -a /tmp/polybar.log
polybar darkin -c "$DOTS_HOME/wm/polybar/config.ini" 2>&1 | tee -a /tmp/polybar.log & disown
