#!/usr/bin/bash

# Set keymap to Spanish layout
setxkeymap es &

# Restore wallpaper
feh --bg-scale --no-fehbg $DOTS_HOME/misc/walls/.wall.jpg &

# Restore cursor theme
xsetroot -cursor_name left_ptr &

# Automounter
udiskie &

# Compositor
picom -f --config $DOTS_HOME/wm/picom/picom.conf &
