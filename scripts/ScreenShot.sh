#!/usr/bin/bash

screenshotfile=$(hyprshot -zs -m $1 -o ~/Pictures/Screenshots -- echo)
swappy -f $screenshotfile -o $screenshotfile
