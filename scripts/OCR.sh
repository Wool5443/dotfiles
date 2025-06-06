#!/usr/bin/env sh
# Dependencies: tesseract imagemagick wl-clipboard hyprshot

die() {
  exit 1
}

cleanup() {
  [[ -n $1 ]] && rm -r "$1"
}

SCR_IMG=$(mktemp -d) || die "failed to create tmpdir"

# shellcheck disable=SC2064
trap "cleanup '$SCR_IMG'" EXIT

hyprshot -m region -f scr.png -zs -o $SCR_IMG
sleep 0.1
mogrify -modulate 100,0 -resize 400% "$SCR_IMG/scr.png" || die "failed to convert image"
tesseract -l eng+rus "$SCR_IMG/scr.png" "$SCR_IMG/scr" &>/dev/null || die "failed to extract text"
sleep 0.1
wl-copy <"$SCR_IMG/scr.txt" || die "failed to copy text to clipboard"
sleep 0.1
exit
