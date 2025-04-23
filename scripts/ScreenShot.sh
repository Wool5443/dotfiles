#!/usr/bin/bash

screenshotfile=$(hyprshot -zs -m $1 -o ~/Pictures/Screenshots -- echo)
shouldedit=$(notify-send --app-name=swappy --action="edit=Edit" Screenshot "Screenshot was captured")

if [ "$shouldedit" == "edit" ]; then
    swappy -f $screenshotfile -o $screenshotfile
fi
