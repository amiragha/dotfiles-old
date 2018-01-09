#!/usr/bin/zsh

userresources=$HOME/.Xresources
usermodmap=$HOME/.Xmodmap
sysresources=/etc/X11/xinit/.Xresources
sysmodmap=/etc/X11/xinit/.Xmodmap

# merge in defaults and keymaps
if [ -f $sysresources ]; then
    xrdb -merge $sysresources
fi
if [ -f $sysmodmap ]; then
    xmodmap $sysmodmap
fi
if [ -f "$userresources" ]; then
    xrdb -merge "$userresources"
fi
if [ -f "$usermodmap" ]; then
    xmodmap "$usermodmap"
fi

#numlockx
#xxkb &
#export PATH=$HOME/.bin:$PATH

# Keyboard layouts
setxkbmap us,ir -option grp:shifts_toggle &

# Starting the rxvt-unicode daemon
#urxvtd -q -f -o &

# Enable compositing using
compton -CGb &

# set cursor
xsetroot -cursor_name left_ptr &

# set background
sh ~/.fehbg &

# Starting Dbus
eval `dbus-launch --auto-syntax`

# Starting taffybar &
#taffybar &

# nm-applet & volume icon
volumeicon &
nm-applet &

# finally Starting the window manager
#xmonad
exec i3
