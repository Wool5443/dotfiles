#!/usr/bin/env python

from shlex import split
from subprocess import run
from json import loads


LIST_CALL = \
    "gdbus call --session --dest org.gnome.Shell --object-path\
    /org/gnome/Shell/Extensions/Windows\
    --method org.gnome.Shell.Extensions.Windows.List"
PID_CALL = \
    "gdbus call --session --dest org.gnome.Shell --object-path\
    /org/gnome/Shell/Extensions/WindowsExt\
    --method org.gnome.Shell.Extensions.WindowsExt.FocusPID"
MOVE_RESIZE_CALL = \
    "gdbus call --session --dest org.gnome.Shell --object-path\
    /org/gnome/Shell/Extensions/Windows\
    --method org.gnome.Shell.Extensions.Windows.MoveResize"


active_pid = int(run(split(PID_CALL), capture_output=True,
                 text=True).stdout[2:-4])
windows = run(split(LIST_CALL), capture_output=True,
              text=True).stdout[2:-4]
windows = loads(windows)

active = None
for w in windows:
    if w["pid"] == active_pid:
        active = w
active_id = active["id"]


move_resize_call = f"{MOVE_RESIZE_CALL} {active_id} 8 48 1904 1024"
run(split(move_resize_call))
