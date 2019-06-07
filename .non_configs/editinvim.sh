#!/bin/bash

file=$(mktemp)
urxvt -e vim -c 'startinsert' "$file" # replace with your favorite terminal

rm $file
