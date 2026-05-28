#!/usr/bin/env sh
# Dependencies: wf-recorder slurp libnotify

set -eu

mode="${1:-fullscreen}"
dir="${XDG_VIDEOS_DIR:-$HOME/Videos}/Screencasts"
template="${SCREENCAST_TEMPLATE:-Screencast_%Y-%m-%d_%H-%M-%S.mp4}"
pidfile="${XDG_RUNTIME_DIR:-/tmp}/wf-recorder-screencast.pid"

mkdir -p "$dir"

notify_saved() {
    action="$(notify-send \
        --expire-time=30000 \
        --app-name=wf-recorder \
        --action="default=Open folder" \
        "Screencast saved" \
        "$file" || true)"

    if [ "$action" = "default" ]; then
        xdg-open "$dir" >/dev/null 2>&1 &
    fi
}

if [ -s "$pidfile" ]; then
    pid="$(cat "$pidfile")"
    if kill -0 "$pid" 2>/dev/null; then
        kill -INT "$pid"
        rm -f "$pidfile"
        exit 0
    fi
    rm -f "$pidfile"
fi

case "$mode" in
region)
    geometry="$(slurp)" || exit 1
    set -- -g "$geometry"
    ;;
output)
    geometry="$(slurp -o)" || exit 1
    set -- -g "$geometry"
    ;;
fullscreen | full)
    set --
    ;;
*)
    notify-send --urgency=critical --app-name=wf-recorder "Unknown screencast mode: $mode"
    exit 1
    ;;
esac

file="$dir/$(date +"$template")"

# Use Intel Quick Sync HEVC. Override via SCREENCAST_CODEC if needed.
wf-recorder \
    "$@" \
    -f "$file" \
    -r "${SCREENCAST_FRAMERATE:-60}" \
    -x "${SCREENCAST_PIXEL_FORMAT:-p010le}" \
    -c "${SCREENCAST_CODEC:-hevc_qsv}" \
    -p "${SCREENCAST_PRESET:-preset=medium}" \
    -p "${SCREENCAST_PROFILE:-profile=main10}" \
    -p "${SCREENCAST_LOW_POWER:-low_power=0}" \
    -p "${SCREENCAST_QUALITY:-global_quality=24}" &

pid="$!"
printf '%s\n' "$pid" >"$pidfile"
notify-send --app-name=wf-recorder "Screencast started" "$file"

set +e
wait "$pid"
status="$?"
set -e
rm -f "$pidfile"

if [ "$status" -eq 0 ]; then
    notify_saved &
else
    notify-send --urgency=critical --app-name=wf-recorder "Screencast failed" "$file"
fi

exit "$status"
