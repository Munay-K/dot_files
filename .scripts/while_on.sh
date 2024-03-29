#!/bin/bash

# Mouse {{{

KEYWORD_OPTICAL_MOUSE="optical mouse"
KEYWORD_TOUCHPAD="touchpad"

ID_OPTICAL_MOUSE=$(xinput --list --short | grep -i "$KEYWORD_OPTICAL_MOUSE" | cut -f 2 | cut -d"=" -f 2)
ID_TOUCHPAD=$(xinput --list --short | grep -i "$KEYWORD_TOUCHPAD" | cut -f 2 | cut -d"=" -f 2)

# Changes mouse speed
xinput --set-prop $ID_OPTICAL_MOUSE "libinput Accel Speed" 1

# Changes mouse speed
xinput --set-prop $ID_TOUCHPAD "libinput Accel Speed" 1
# Disables/Enables the touchpad
xinput --set-prop $ID_TOUCHPAD "Device Enabled" 0

# Changes cursor speed
xset r rate 90 50

#}}}

# Keyboard {{{

# Changes keyboard layout
setxkbmap -layout us

# Maps caps lock to escape
setxkbmap -option caps:swapescape

#}}}

# General {{{

# Load all the settings for the X applications.
xrdb ~/.Xresources

# Load wallpaper
 feh --bg-fill ~/.config/wallpaper

#}}}
