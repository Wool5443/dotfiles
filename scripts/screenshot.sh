#!/usr/bin/env sh

screenshotfile=$(hyprshot -z -s -m $1 -o ~/Pictures/Screenshots -- echo)
action=$(notify-send --expire-time=30000 --app-name=swappy --action="edit=Edit" --action="show=Show in folder" Screenshot "Screenshot was captured")

case "$action" in
    edit)
        swappy -f "$screenshotfile" -o "$screenshotfile"
        ;;
    show)
        xdg-open "$(dirname "$screenshotfile")"
        ;;
esac
