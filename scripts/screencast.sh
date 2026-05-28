#!/usr/bin/env sh
# Dependencies: wf-recorder slurp libnotify pactl

set -eu

mode="${1:-fullscreen}"
dir="${XDG_VIDEOS_DIR:-$HOME/Videos}/Screencasts"
template="${SCREENCAST_TEMPLATE:-Screencast_%Y-%m-%d_%H-%M-%S.mp4}"
pidfile="${XDG_RUNTIME_DIR:-/tmp}/wf-recorder-screencast.pid"

mkdir -p "$dir"

notify_saved() {
    action="$(notify-send \
        --expire-time=10000 \
        --app-name=wf-recorder \
        --action="show=Show in folder" \
        "Screencast saved" \
        "$file" || true)"

    if [ "$action" = "show" ]; then
        xdg-open "$dir" >/dev/null 2>&1 &
    fi
}

desktop_audio_source() {
    if [ "${SCREENCAST_AUDIO_SOURCE+x}" ]; then
        printf '%s\n' "$SCREENCAST_AUDIO_SOURCE"
        return 0
    fi

    if command -v pactl >/dev/null 2>&1; then
        sink="$(pactl get-default-sink 2>/dev/null || true)"
        if [ -n "$sink" ]; then
            printf '%s.monitor\n' "$sink"
            return 0
        fi
    fi

    return 1
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
audio_source="$(desktop_audio_source)" || {
    notify-send --urgency=critical --app-name=wf-recorder "Could not find desktop audio source"
    exit 1
}

# Use Intel Quick Sync HEVC. Override via SCREENCAST_CODEC if needed.
wf-recorder \
    "$@" \
    --audio="$audio_source" \
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
