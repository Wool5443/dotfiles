#!/usr/bin/env sh

set -eu

freeze=-z
output_dir=$HOME/Pictures/Screenshots
filename=$(date +'%Y-%m-%d-%H%M%S.png')
screenshotfile=$output_dir/$filename

case " $* " in
*" output "*)
    freeze=
    ;;
esac

case "${1-} ${2-}" in
"active output")
    spectacle_mode=--current
    set -- -m active -m output
    ;;
"window ")
    spectacle_mode=--activewindow
    set -- -m window
    ;;
"region ")
    spectacle_mode=--region
    set -- -m region
    ;;
*)
    printf 'Usage: %s {region|window|active output}\n' "$0" >&2
    exit 2
    ;;
esac

mkdir -p "$output_dir"
case ":${XDG_CURRENT_DESKTOP:-}:" in
*:KDE:*) spectacle --background --nonotify "$spectacle_mode" --output "$screenshotfile" ;;
*) hyprshot $freeze -s "$@" -f "$filename" -o "$output_dir" ;;
esac

[ -f "$screenshotfile" ] || exit

action=$(notify-send --expire-time=10000 --app-name=Screenshot --action="edit=Edit" --action="show=Show in folder" Screenshot "Screenshot was captured" || true)

case "$action" in
edit)
    case ":${XDG_CURRENT_DESKTOP:-}:" in
    *:KDE:*) spectacle --edit-existing "$screenshotfile" ;;
    *) swappy -f "$screenshotfile" -o "$screenshotfile" ;;
    esac
    ;;
show)
    xdg-open "$(dirname "$screenshotfile")"
    ;;
esac
