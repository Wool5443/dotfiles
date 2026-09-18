#!/usr/bin/env sh

freeze=-z
output_dir=$HOME/Pictures/Screenshots
filename=$(date +'%Y-%m-%d-%H%M%S_hyprshot.png')
screenshotfile=$output_dir/$filename

case " $* " in
*" output "*)
    freeze=
    ;;
esac

case "$1 ${2-}" in
"active output")
    set -- -m active -m output
    ;;
"window ")
    set -- -m window
    ;;
"region ")
    set -- -m region
    ;;
*)
    printf 'Usage: %s {region|window||active output}\n' "$0" >&2
    exit 2
    ;;
esac

mkdir -p "$output_dir"
hyprshot $freeze -s "$@" -f "$filename" -o "$output_dir"

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
