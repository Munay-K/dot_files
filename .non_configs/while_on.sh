#!/bin/bash

# Changes cursor speed
xset r rate 90 50

# Changes mouse speed
xinput --set-prop "SynPS/2 Synaptics TouchPad" "libinput Accel Speed" 1

# Changes keyboard layout
setxkbmap -layout us

# Maps caps lock to escape
setxkbmap -option caps:swapescape

# Disables touchpad
xinput set-prop 'SynPS/2 Synaptics TouchPad' 'Device Enabled' 0

# Load all the settings for the X applications.
xrdb ~/.Xresources

# Load wallpaper
feh --bg-fill ~/.config/wallpaper
