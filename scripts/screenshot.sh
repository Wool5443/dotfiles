#!/usr/bin/env sh

mode=$*
freeze=-z
output_dir=$HOME/Pictures/Screenshots
filename=$(date +'%Y-%m-%d-%H%M%S_hyprshot.png')
screenshotfile=$output_dir/$filename

case " $mode " in
*" output "*)
    freeze=
    ;;
esac

hyprshot $freeze -s -m $mode -f "$filename" -o "$output_dir"

[ -f "$screenshotfile" ] || exit

action=$(notify-send --expire-time=10000 --app-name=swappy --action="edit=Edit" --action="show=Show in folder" Screenshot "Screenshot was captured")

case "$action" in
edit)
    swappy -f "$screenshotfile" -o "$screenshotfile"
    ;;
show)
    xdg-open "$(dirname "$screenshotfile")"
    ;;
esac
