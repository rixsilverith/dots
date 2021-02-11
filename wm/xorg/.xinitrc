#!/bin/sh

# Define the directory where the Zsh configuration files live 
export ZDOTDIR=$HOME/.dots/shell/zsh

# Xorg related files
userresources=$HOME/.Xresources
usermodmap=$HOME/.Xmodmap
sysresources=/etc/X11/xinit/.Xresources
sysmodmap=/etc/X11/xinit/.Xmodmap

# merge in defaults and keymaps
[[ -f $sysresources ]] && xrdb -merge $sysresources
[[ -f $sysmodmap ]] && xmodmap $sysmodmap
[[ -f "$userresources" ]] && xrdb -merge "$userresources"
[[ -f "$usermodmap" ]] && xmodmap "$usermodmap"

# start some nice programs
if [ -d /etc/X11/xinit/xinitrc.d ] ; then
    for f in /etc/X11/xinit/xinitrc.d/?*.sh ; do
        [ -x "$f" ] && . "$f"
    done
    unset f
fi

# autostart before the window manager
setxkbmap es &
feh --bg-scale $HOME/.dots/misc/.wallpaper.jpg
xsetroot -cursor_name left_ptr &
udiskie &
picom -f &
exec bspwm
