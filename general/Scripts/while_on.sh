# Change cursor speed
xset r rate 100 50
# Change mouse speed
xinput --set-prop "SynPS/2 Synaptics TouchPad" "libinput Accel Speed" 1
# Change keyboard layout
setxkbmap -layout us

#Change desktop background every 2 seconds
watch -n 120 feh --randomize --bg-fill ~/Documents/MyFiles/Miscelanous/Wallpapers/* &

