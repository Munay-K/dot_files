#!/bin/sh

BASEDIR=$(dirname "$0")
cd $BASEDIR

xrandr --auto --output HDMI1 --mode 1920x1080i --above LVDS1
./while_on.sh
