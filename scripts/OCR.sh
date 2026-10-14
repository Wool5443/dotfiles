#!/usr/bin/env sh
# Dependencies: tesseract (eng+rus), imagemagick, wl-clipboard,
# and Spectacle on KDE or hyprshot on Hyprland.

set -eu
SCR_IMG=$(mktemp -d)
trap 'rm -rf -- "$SCR_IMG"' EXIT
trap 'exit 1' HUP INT TERM

case ":${XDG_CURRENT_DESKTOP:-}:" in
*:KDE:*) spectacle --background --nonotify --region --output "$SCR_IMG/scr.png" ;;
*) hyprshot -m region -f scr.png -zs -o "$SCR_IMG" ;;
esac

# A cancelled selection produces no image.
[ -s "$SCR_IMG/scr.png" ] || exit 1
magick mogrify -modulate 100,0 -resize 400% "$SCR_IMG/scr.png"
tesseract -l "${OCR_LANGUAGES:-eng+rus}" "$SCR_IMG/scr.png" "$SCR_IMG/scr" >/dev/null 2>&1
wl-copy <"$SCR_IMG/scr.txt"
