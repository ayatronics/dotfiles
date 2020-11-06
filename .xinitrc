#!/bin/sh

userresources=$HOME/.Xresources
usermodmap=$HOME/.Xmodmap
sysresources=/etc/X11/xinit/.Xresources
sysmodmap=/etc/X11/xinit/.Xmodmap

# merge in defaults and keymaps

if [ -f "$sysresources" ]; then
  xrdb -merge "$sysresources"
fi

if [ -f "$sysmodmap" ]; then
  xmodmap "$sysmodmap"
fi

if [ -f "$userresources" ]; then
  xrdb -merge "$userresources"
fi

if [ -f "$usermodmap" ]; then
  xmodmap "$usermodmap"
fi

# start some nice programs

if [ -d /etc/X11/xinit/xinitrc.d ]; then
  for f in /etc/X11/xinit/xinitrc.d/?*; do
    [ -x "$f" ] && . "$f"
  done
  unset f
fi

# XDG
export XDG_CONFIG_HOME=~/.config

# variable
export HOSTNAME_DESKTOP='pihla'
export HOSTNAME_LAPTOP='kukka'

# keymap
setxkbmap -model pc104 -layout jp,us
if [ "$HOSTNAME" = "$HOSTNAME_LAPTOP" ]; then
  setxkbmap -option ctrl:swapcaps
fi
xmodmap -e "keycode 115 = Super_L" -e "add mod4 = Super_L"

# video
xset -dpms
xset s off
xset s noblank
if [ "$HOSTNAME" = "$HOSTNAME_DESKTOP" ]; then
  nvidia-settings --load-config-only
  nvidia-settings -a InitialPixmapPlacement=2
  export __GL_SYNC_TO_VBLANK=1
fi
compton -b --backend glx --vsync opengl-swc &

# sound
start-pulseaudio-x11

# display
if [ "$HOSTNAME" = "$HOSTNAME_DESKTOP" ]; then
  xrandr --output HDMI-0 --mode 3840x2160 &
  # xrandr --output HDMI-1 --off &
  xrandr --output HDMI-1 --mode 3840x2160 --same-as HDMI-0 &
fi
xrandr --dpi 144 &
if [ "$HOSTNAME" = "$HOSTNAME_DESKTOP" ]; then
  xrandr --size 3840x2160 &
fi

# awesome theme font
case "$HOSTNAME" in
  "$HOSTNAME_DESKTOP") export AWESOME_THEME_FONT="sans 10" ;;
esac

# encfs
if [ "$HOSTNAME" = "$HOSTNAME_DESKTOP" ]; then
  encfs -S ~/Dropbox/.crypt ~/crypt <~/.keyfile/key_storage
fi
encfs -S ~/Dropbox/.crypt-mini ~/crypt-mini <~/.keyfile/key_storage_mini

# input method
export GTK_IM_MODULE=fcitx
export QT_IM_MODULE=fcitx
export XMODIFIERS="@im=fcitx"
fcitx &

# programs
xscreensaver -no-splash &
dropbox &

exec awesome
