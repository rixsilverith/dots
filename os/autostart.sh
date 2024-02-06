#!/bin/bash

setxkbmap es
feh --bg-scale --no-fehbg "$DOTS_HOME/misc/walls/.wall.jpg"
xsetroot -cursor_name left_ptr
udiskie &
picom -f --config "$DOTS_HOME/os/picom/picom.conf" &
